# STRING <- STRING WRITER
WriteString ← |2 $"\"_\"" ;∶
~~~
⍤ "writing a string fails" ≅ "\"test\"" WriteString "test" (∘)
~~~

# STRING <- NUMBER WRITER
WriteNumber ← |2 $"_" ;∶
~~~
⍤ "writing an integer fails" ≅ "123" WriteNumber 123 (∘)
⍤ "writing a float fails" ≅ "123.45" WriteNumber 123.45 (∘)
~~~

# STRING <- _ WRITER
WriteTrue ← |2 "true";;
~~~
⍤ "writing true fails" ≅ "true" WriteTrue 1 (∘)
~~~

# STRING <- _ WRITER
WriteFalse ← |2 "false";;
~~~
⍤ "writing false fails" ≅ "false" WriteFalse 0 (∘)
~~~

WriteNull ← |2 "null";;
~~~
⍤ "writing null fails" ≅ "null" WriteNull 0 (∘)
~~~

# STRING <- ARRAY WRITER
WriteArray ← |2 ?("[]";;) ($"[_]" ⊔/(|2 □ ⊂ ⊂ ∶ ", " ⊔⊙⊔) ∺(|2 □ ! . ∶ ⊔)) = 0 ⧻ .

WriteObject ← |2 $"{_}" ⊔/(|2 □ ⊂ ⊂ ∶ ", " ⊔⊙⊔) ∺(|2 □ ⊂⊂ ∶ ": " !. ∶ ⊔⊡0 ⊙⊙(|2 ! . ∶ ⊔ ⊡1) ,,) ⍉
WriteEmptyObject ← |2 "{}";;

SelfApply ← |2 ! .
WriteJson ← |1 SelfApply (|2 
  ! ⊡ ∶ [
    (?(WriteNumber) (WriteArray) = 0 ⧻ △ .)
    (?(WriteString) (WriteArray) = 1 ⧻ △ .)
    (
      ! ⊡ ∶ [(?(?(WriteNull) (0 ⍤ . $"Failed to write overly-boxed value _" ;∶) = 0 . ⊔) (|2 ?(|2 WriteTrue) (|2 WriteFalse) = 1 .) = 2 type . ⊔)
             (?(WriteEmptyObject) (WriteArray) = 0 ⧻ .)
             (WriteObject)] ⧻ △ .
    )
  ] type . ∶
)

WriteJson □[]

~~~
⍤ "writing strings fails" ≅ "\"test\"" WriteJson "test"

⍤ "writing integers fails" ≅ "123" WriteJson 123
⍤ "writing floats fails" ≅ "123.45" WriteJson 123.45

⍤ "writing true fails" ≅ "true" WriteJson (1)
⍤ "writing false fails" ≅ "false" WriteJson (0)
⍤ "writing null fails" ≅ "null" WriteJson ((0))

⍤ "writing empty objects fails" ≅ "{}" WriteJson □[]
⍤ "writing singlton objects fails" ≅ "{\"a\": 3}" WriteJson ⍉[{"a" 3}]
⍤ "writing object with multiple simple values fails" ≅ "{\"a\": 2, \"b\": false}" WriteJson ⍉[{"a" 2} {"b" (0)}]
⍤ "writing object containing objects fails" ≅ "{\"a\": {\"c\": 3}, \"b\": 0}" WriteJson ⍉ [{"a" ⍉[("c")_(3)]} {"b" 0}]
⍤ "writing object containing arrays fails" ≅ "{\"a\": [1, 2, 3]}" WriteJson ⍉ [("a")_(1_2_3)]

⍤ "writing empty array fails" ≅ "[]" WriteJson []
⍤ "writing singleton array fails" ≅ "[1]" WriteJson {1}
⍤ "writing array with multiple simple values fails" ≅ "[1, \"test\", true]" WriteJson {1 "test" (1)}
⍤ "writing array containing arrays fails" ≅ "[[1, 2, 3]]" WriteJson {{1 2 3}}
⍤ "writing array containing objects fails" ≅ "[{\"a\": 3}, false]" WriteJson {⍉[("a")_(3)] (0)}
~~~

[WriteJson]
