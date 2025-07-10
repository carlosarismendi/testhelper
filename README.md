# Test helper

## Install
`go get github.com/carlosarismendi/testhelper`

## Description

This project that provides a couple of functions to compare from primitive types to structs and maps build on top of [stretchr/testify](https://pkg.go.dev/github.com/stretchr/testify):

```go
// If the comparison fails, it kills the execution. When comparing maps, ignoreFields
// only applies for structs that are the values of the map.
// Unexported fields are ignored.
// Uses methods from https://pkg.go.dev/github.com/stretchr/testify/require.
func RequireEqual(t testing.TB, expected, actual interface{}, ignoreFields ...string) {...}


// If the comparison fails, it does not kill the execution. When comparing maps, ignoreFields
// only applies for structs that are the values of the map.
// Unexported fields are ignored.
// Uses methods from https://pkg.go.dev/github.com/stretchr/testify/assert.
func AssertEqual(t testing.TB, expected, actual interface{}, ignoreFields ...string) {...}
```

## Examples

```go
package main

import (
    "testing"
    "github.com/carlosarismendi/testhelper"
)

func TestCompare1(t *testing.T) {
    actual := map[string]int{
        "field1": 1,
        "field2": 3,
    }
    expected := map[string]int{
        "field1": 1,
        "field2": 2,
    }
    
    // FAIL: but allows the code to continue. 
    testhelper.AssertEqual(t, expected, actual)

    // FAIL: and kills the process, so following code won't be reached.
    testhelper.RequireEqual(t, expected, actual)

    // {...} other code
}

func TestCompare2(t *testing.T) {
    actual := Resource{
        ID:   "id",
        Name: "name",
        Nested:  &NestedResource{
            ID:     "actualID",
            Number: 65,
        },
    }
    expected: Resource{
        ID:   "id",
        Name: "name",
        Nested: &NestedResource{
            ID:     "expectedID",
            Number: 25,
        },
    }

    // PASS: despite Nested being different because it's skipped.
    testhelper.AssertEqual(t, expected, actual, "Nested")
    // OR testhelper.RequireEqual(t, expected, actual)
}
```
