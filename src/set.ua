# SetContains <- FUNCTION VALUE ARRAY
SetContains ← /↥ ∺(|3 !∶⊙∶) ∶⊙∶∶
~~~
⍤ "checking if a number is in a set including the number using equality fails" = 1 SetContains (=) 1 1_2_3
⍤ "checking if a number is in a set not including the number using equality fails" = 0 SetContains (=) 0 1_2_3
⍤ "checking if an array is in a set including the array using match fails" = 1 SetContains (≅) 1_2_3 [3_4_1 1_2_3 2_5_7]
⍤ "checking if an array is in a set not including the array using match fails" = 0 SetContains (≅) 1_2_3 [3_4_1 2_5_3]
⍤ "checking if a boxed array is in a set including it using unboxed-matching fails" = 1 SetContains (≅⊔∶⊔) ("ab") [("ab") ("cd") ("ef")]
~~~

# BOOLEAN <- FUNCTION SUBSET SUPERSET
SetIsSubset ← ?(1;;;) (/↧ ∺(SetContains ∶⊙∶) ⊙∶) = 0 ⧻. ∶
~~~
⍤ "checking if a subset is a subset of a superset fails" = 1 SetIsSubset (=) 1_2 1_2_3
⍤ "checking if an unordered subset is a subset of a superset fails" = 1 SetIsSubset (=) 2_1 1_2_3
⍤ "checking if a superset is a subset of a subset fails" = 0 SetIsSubset (=) 1_2_3 1_2
⍤ "checking if a set is a subset of itself fails" = 1 SetIsSubset (=) 1_2_3 1_2_3
⍤ "checking if a set is a subset of an unordered version itself fails" = 1 SetIsSubset (=) 1_2_3 3_1_2
⍤ "checking if a set is a subset of a disjoin set fails" = 0 SetIsSubset (=) 1_2 3_4
⍤ "checking if a subset is a subset of a superset fails when using boxing" = 1 SetIsSubset (≅⊔∶⊔) [("ab") ("ef")] [("ab") ("cd") ("ef")]
⍤ "checking if an empty set is a subset of a set fails" = 1 SetIsSubset (=) [] 1_2_3
~~~

# BOOLEAN <- FUNCTION ARRAY ARRAY
SetEquals ← ?(↧ ⊙SetIsSubset SetIsSubset ⊙∶ ⊙⊙∶ ⊙∶ . ⊙(,,)) (0;;;) ∶ ⊙(= ⧻,⧻,)
~~~
⍤ "checking if two identical sets are equal fails" = 1 SetEquals (=) 1_2_3 1_2_3
⍤ "checking if two unordered sets are equal fails" = 1 SetEquals (=) 1_2_3 3_1_2
⍤ "checking if a subset and a superset are equal fails" = 0 SetEquals (=) 1_2 1_2_3
⍤ "checking if a superset and a subset are equal fails" = 0 SetEquals (=) 1_2_3 1_2
⍤ "checking if disjoint sets are equal fails" = 0 SetEquals (=) 1_2 3_4
⍤ "checking if equal arrays of boxed values are equal fails" = 1 SetEquals (≅ ⊔∶⊔) [("ef") ("ab") ("cd")] [("ab") ("cd") ("ef")]
⍤ "checking if an empty array and a full array are equal fails" = 0 SetEquals (=) [] 1_2_3
⍤ "checking if a full array and an empty array are equal fails" = 0 SetEquals (=) [] 1_2_3
⍤ "checking if two empty arrays are equal fails" = 1 SetEquals (=) [] []
~~~

SetContains_SetIsSubset_SetEquals

~~~
SetContains_SetIsSubset_SetEquals
~~~
