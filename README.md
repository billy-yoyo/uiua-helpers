
# Uiua Helpers

These are a set of helper functions for Uiua. I'll be adding to these and improving them. All of them have tests, some of them I haven't added here as they're mainly used as internal helpers for the other modules but you're welcome to use them anyway.

Here's some brief documentation about some of the modules;

## Module: `obj.ua`

This is a file which helps defining and manipulating key/value objects. Basic usage is as follows:

### Defining an object

The easiest way to define an object is using the following syntax

    ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]

### Methods

Objects are stored as an array with two rows, the first being the list of keys and the second being the list of values corresponding to the keys. This makes it easy to get/set/delete keys which is what we want to optimize for. We use transpose as it means we can instead define the array as a series of key/value pairs. 

The following is a list of methods to manipulate the object. In all of the following `Object` should be assumed to be an object as defined above.

    GetKey "name" Object

This fetches the value corresponding to the key `"name"` within `Object`

    SetKey "name" value Object

This sets the key `"name"` within `Object` to the value `value`. Here value should be unboxed, the method will box it for you (unless you want to store a boxed value!). If the key `"name"` doesn't already exist, this will append a new key/value pair onto `Object`.

    DeleteKey "name" Object

This deletes the key `"name"` and its corresponding value from `Object`.

    HasKey "name" Object

This returns a boolean depending on if the key `"name"` is present in `Object` or not.

    ObjectsEqual Object Object

This returns a boolean depending on if the two objects are equal, ignoring key ordering.

    ObjectKeys Object

This returns an array of boxed keys within `Object`

    ObjectValues Object

This returns an array of boxed values within `Object` (this will have the same ordering as `ObjectKeys`)

## Module: `json_parse.ua`

This exports a single method `ParseJson` which accepts a single string and returns the decoded json value at the start of the string (ignoring any extra), or an error if it fails to decode a valid json value.

    ParseJson "{ \"a\": 3, \"b\": [1, false, true, 1.3, \"example\"] }"

The parser will convert json types to the following uiua structures:

1. `number` gets converted to numbers
2. `boolean`` gets converted to boxed boolean number (i.e. `(1)` for `true` and `(0)` for `false`). This is so when writing the json we know to convert them back to booleans rather than numbers
3. `string` gets converted to character arrays
4. `null` gets converted to a double-boxed 0 (i.e. `((0))`)
5. `array` gets converted to a boxed array of decoded values
6. `object` gets converted to an object as defined in `obj.ua`

## Module: `json-writer.ua`

This exports a single method `WriteJson` which accepts a json value (listed as one of the returned structures above) and converts it into a json string.

    WriteJson ⍉[{"a" 3} {"b" [1 (0) (1) 1.3 "example"]}]

This acts as an inverse of `ParseJson` and so should preserve things like `null`, `false`, `true` and empty objects/arrays even if they don't exist in uiua.

