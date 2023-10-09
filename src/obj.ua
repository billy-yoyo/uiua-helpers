Array ← &i "array.ua"
ReplaceIndex ← use "ReplaceIndex" Array
DeleteIndex ← use "DeleteIndex" Array

Set ← &i "set.ua"
SetEquals ← use "SetEquals" Set

ObjectKeys ← ?(∘) (⊡0) = 0 ⧻ .
ObjectValues ← ?(∘) (⊡1) = 0 ⧻ .

# INDEX <- KEY OBJECT
GetIndex ← ⊗1 ∺(≅⊔) ObjectKeys ⊙⊔∶
~~~
⍤ "getting index for key at start of object fails" = 0 GetIndex "a" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting index for in middle of object fails" = 1 GetIndex "b" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting index for at end of object fails" = 2 GetIndex "c" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting index for for singleton object fails" = 0 GetIndex "a" ⍉[{"a" "f"}]
⍤ "getting index for non existant key for object returns length" = 3 GetIndex "d" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting index for non existant key for singleton object returns 1" = 1 GetIndex "d" ⍉[{"a" "f"}]
~~~

# VALUE <- KEY OBJECT
GetKey ← !ObjectKeys ↙1↘ ⍜∶(ObjectValues) GetIndex ⊙. ⊙⊔
~~~
⍤ "getting value for key at start of object fails" ≅ "f" GetKey "a" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting value for in middle of object fails" ≅ 1_2_3 GetKey "b" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting value for at end of object fails" = 0 GetKey "c" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "getting value for for singleton object fails" ≅ "f" GetKey "a" ⍉[{"a" "f"}]
~~~

# BOOLEAN <- KEY OBJECT
HasKey ← ≠ ⧻ObjectKeys∶ GetIndex ⊙. ⊙⊔
~~~
⍤ "checking if present key exists at start of object fails" = 1 HasKey "a" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "checking if present key exists in middle of object fails" = 1 HasKey "b" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "checking if present key exists at end of object fails" = 1 HasKey "c" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "checking if present key exists for singleton object fails" = 1 HasKey "a" ⍉[{"a" "f"}]
⍤ "checking if missing key exists fails" = 0 HasKey "d" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}]
⍤ "checking if missing key exists for singleton object fails" = 0 HasKey "d" ⍉[{"a" "f"}]
~~~

# BOOLEAN <- OBJECT OBJECT
ObjectKeysEqual ← |2 SetEquals (≅ ⊔∶⊔) ⊙(ObjectKeys) ObjectKeys
~~~
⍤ "checking equality of two equal object keysets fails" = 1 ObjectKeysEqual ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}] ⍉[{"b" 1_2_3} {"a" "f"} {"c" 0}]
⍤ "checking equality of two non-equal object keysets fails" = 0 ObjectKeysEqual ⍉[{"a" "f"} {"b" 1_2_3} {"c" 0}] ⍉[{"b" 1_2_3} {"a" "f"}]
~~~

# BOOLEAN <- ANY ANY
ValueEquality ← |2 ?(?(=)(≅) = 0 ⧻△) (0;;;) = type∶type ⊙∶ .,, ⊔∶⊔
~~~
⍤ "checking equality of two equal ints fails" = 1 ValueEquality 1 1
⍤ "checking equality of two equal arrays fails" = 1 ValueEquality 1_2_3 1_2_3
⍤ "checking equality of two equal boxed ints fails" = 1 ValueEquality (1) (1)
⍤ "checking equality of two equal arrays ints fails" = 1 ValueEquality (1_2_3) (1_2_3)
⍤ "checking equality of two equal strings fails" = 1 ValueEquality "abc" "abc"
⍤ "checking equality of two unequal ints fails" = 0 ValueEquality 5 1
⍤ "checking equality of two unequal arrays fails" = 0 ValueEquality 3_4_5 1_2_3
⍤ "checking equality of two unequal boxed ints fails" = 0 ValueEquality (3) (1)
⍤ "checking equality of two unequal arrays ints fails" = 0 ValueEquality (5_6_7) (1_2_3)
⍤ "checking equality of two unequal strings fails" = 0 ValueEquality "abc" "efg"
⍤ "checking equality of two different types fails" = 0 ValueEquality 1 "a"
~~~

# BOOLEAN <- OBJECT OBJECT
ObjectKeyValuesEqual ← /↧ ∺(ValueEquality ⊙(GetKey) GetKey ⊙∶ .⊔) ObjectKeys . ⊔ ⊙⊔
~~~
⍤ "checking equality of equal key values fails" = 1 ObjectKeyValuesEqual ⍉[{"a" "f"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of unequal key values fails" = 0 ObjectKeyValuesEqual ⍉[{"a" "d"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
~~~

# BOOLEAN <- OBJECT OBJECT
ObjectsEqual ← ?ObjectKeyValuesEqual (0;;) ObjectKeysEqual ,, ⊔ ⊙⊔
~~~
⍤ "checking equality of equal objects fails" = 1 ObjectsEqual ⍉[{"a" "f"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of unequal object keys fails" = 0 ObjectsEqual ⍉[{"e" "f"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of unequal object values fails" = 0 ObjectsEqual ⍉[{"a" "2"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of unequal object key and value fails" = 0 ObjectsEqual ⍉[{"a" "2"} {"c" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of unequal object value types fails" = 0 ObjectsEqual ⍉[{"a" 1} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3}]
⍤ "checking equality of an empty object and another object fails" = 0 ObjectsEqual [] ⍉[{"a" 1} {"b" 1_2_3}]
~~~

# NEW_OBJECT <- _ KEY VALUE OBJECT
AppendKV ← ?(↯2_1 ;) (⍜⍉⊂) = 0 ⧻. ∶ ⊂ ∶□∶□ ; ⊙⊙⊙⊔
~~~
⍤ "appending key value to object fails" = 1 ObjectsEqual AppendKV 0 "c" 2 ⍉[{"a" "f"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3} {"c" 2}]
⍤ "appending key value to an empty object fails" = 1 ObjectsEqual AppendKV 0 "a" 1 [] ⍉[{"a" 1}]
~~~

# NEW_OBJECT <- INDEX _ VALUE OBJECT
ReplaceKV ← ⊙; ⊟∶ ReplaceIndex ⊙⊙⊙(ObjectKeys.) ⊙⊙(ObjectValues.) ⊙; ⊙⊙⊙⊔
~~~
⍤ "replacing value for key at start of object fails" = 1 ObjectsEqual ReplaceKV 0 "a" 3 ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"a" 3} {"b" 1_2_3} {"c" 9}]
⍤ "replacing value for key in middle of object fails" = 1 ObjectsEqual ReplaceKV 1 "b" 3 ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"a" "f"} {"b" 3} {"c" 9}]
⍤ "replacing value for key at end of object fails" = 1 ObjectsEqual ReplaceKV 2 "c" 3 ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"a" "f"} {"b" 1_2_3} {"c" 3}]
~~~

# NEW_OBJECT <- KEY VALUE OBJECT
SetKey ← ?AppendKV ReplaceKV = ⊃(⧻ObjectKeys⋅⋅⋅⋅∘)(⊙⊙⊙⊙∘) . GetIndex ⊙∶ ⊙⊙,. ⊙⊙⊔
~~~
⍤ "setting an existing key fails" = 1 ObjectsEqual SetKey "a" 3 ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"a" 3} {"b" 1_2_3} {"c" 9}]
⍤ "setting a new key fails" = 1 ObjectsEqual SetKey "c" 9 ⍉[{"a" "f"} {"b" 1_2_3}] ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}]
⍤ "setting key on an empty object fails" = 1 ObjectsEqual SetKey "a" 1 [] ⍉[{"a" 1}]
⍤ "setting key on a singleton object fails" = 1 ObjectsEqual SetKey "b" 3 ⍉[{"a" 1}] ⍉[{"a" 1} {"b" 3}]
~~~

# NEW_OBJECT <- KEY OBJECT
DeleteKey ← ⊟ ⊙(DeleteIndex ⊙(ObjectValues)) DeleteIndex ⊙(ObjectKeys) ,, GetIndex ⊙. ⊙⊔
~~~
⍤ "deleting an existing key fails" = 1 ObjectsEqual DeleteKey "a" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"b" 1_2_3} {"c" 9}]
⍤ "deleting a non-existent key fails" = 1 ObjectsEqual DeleteKey "d" ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}] ⍉[{"a" "f"} {"b" 1_2_3} {"c" 9}]
~~~

GetKey_HasKey_ObjectKeysEqual_ValueEquality_ObjectsEqual_SetKey_DeleteKey_ObjectKeys_ObjectValues
~~~
GetKey_HasKey_ObjectKeysEqual_ValueEquality_ObjectsEqual_SetKey_DeleteKey_ObjectKeys_ObjectValues
~~~
