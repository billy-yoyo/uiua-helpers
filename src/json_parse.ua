Util ← &i "util.ua"
Trim ← use "Trim" Util

Obj ← &i "obj.ua"
SetKey ← use "SetKey" Obj
GetKey ← use "GetKey" Obj
ObjectsEqual ← use "ObjectsEqual" Obj

SelfApply ← |2 ! .

BoxResult ← |2 ⊂ ∶□∶□
~~~
⍤ "boxing two values fails to properly box" ≅ [2 2] ∵(type) BoxResult 2 "hello"
⍤ "boxing two values doesnt preserve first value" = 2 ⊔ ⊡ 0 BoxResult 2 "hello"
⍤ "boxing two values doesnt preserve second value" ≅ "hello" ⊔ ⊡ 1 BoxResult 2 "hello"
~~~

UnboxResult ← |1.2 ⊙(⊔ ⊡ 1) ⊔ ⊡ 0 .

# Object <- STRING PARSER
ParseString ← |2 ?(0 ⍤ . $"Invalid JSON failed to parse at _" ;) (BoxResult ⊙(↘+1) ↙ ⊙, .) = ⊙(⧻,) .⊗ 1 -∶ ⊙(×) . ⊙∶ = @" . ∶ ⊂ 0 ⍜⇌(↘1) ∵(= 1 ◿2) \(?(0;) (+1) = 0 ∶) = @\\ . ↘ 1 ;∶
~~~
⍤ "parsing valid strings fails" ↧ ⊙(≅ " world") ≅ "hello" UnboxResult ParseString "\"hello\" world" (∘)
⍤ "parsing valid strings with escaping fails" ↧ ⊙(≅ " world") ≅ "he\\\"llo" UnboxResult ParseString "\"he\\\"llo\" world" (∘)
⍤ "parsing anything else doesnt fail" ⍣(0 UnboxResult ParseString "false hello world" (∘))(1)
~~~

# OBJECT <- STRING PARSER
ParseObject ← |2 ?(|2 BoxResult □[] ↘1 ;∶) (!(|3 ↬ ?(0 BoxResult ∶ ↘ 1 ⊙⊙;) (?(|3.4 1 ∶ ↘ 1) (|3.4 0 0 0 0 ⍤ . $"Invalid JSON failed to parse at _" ;∶;∶) ≅ "," ↙ 1 .) ≅ "}" ↙ 1 . Trim ∶ SetKey ⊙∶∶ ⊙⊙(|2.2 UnboxResult !. ,) ⊙⊙(?(↘ 1) (0 ⍤ . $"Failed to parse JSON at: _") ≅ ":" ↙ 1 . Trim) ⊙(|2.2 UnboxResult ParseString Trim) ⊙⊙.) []) ≅ "}" ↙ 1 . Trim ↘ 1

# OBJECT <- STRING PARSER
ParseArray ← |2 ?(|2 BoxResult [] ↘1 ;∶) (!(|3 ↬ ?(0 BoxResult ∶ ↘ 1 ⊙⊙;) (?(|3.4 1 ∶ ↘ 1) (|3.4 0 0 0 0 ⍤ . $"Invalid JSON failed to parse at _" ;∶;∶) ≅ "," ↙ 1 .) ≅ "]" ↙ 1 . ∶ ⊂ ⊙(□) ⊙(|2.2 UnboxResult !. ,)) []) ≅ "]" ↙ 1 . Trim ↘ 1

# OBJECT <- STRING PARSER
ParseTrue ← |2 BoxResult ?(□ 1 ↘ 4 ;∶) (0 "" ⍤ . $"Invalid JSON failed to parse at _" ;∶) ≅ "true" ↙ 4 .
~~~
⍤ "parsing true fails" ↧ ⊙(≅ " hello world") = 1 ⊔ UnboxResult ParseTrue "true hello world" (∘)
⍤ "parsing anything else doesnt fail" ⍣(0 UnboxResult ParseTrue "false hello world" (∘))(1)
~~~

# OBJECT <- STRING PARSER
ParseFalse ← |2 BoxResult ?(□ 0 ↘ 5 ;∶) (0 "" ⍤ . $"Invalid JSON failed to parse at _" ;∶) ≅ "false" ↙ 5 .
~~~
⍤ "parsing false fails" ↧ ⊙(≅ " hello world") = 0 ⊔ UnboxResult ParseFalse "false hello world" (∘)
⍤ "parsing anything else doesnt fail" ⍣(0 UnboxResult ParseFalse "true hello world" (∘))(1)
~~~

# OBJECT <- STRING PARSER
ParseNull ← |2 BoxResult ?(□□0 ↘ 4 ;∶) (0 "" ⍤ . $"Invalid JSON failed to parse at _" ;∶) ≅ "null" ↙ 4 .
~~~
⍤ "parsing false fails" ↧ ⊙(≅ " hello world") = 0 ⊔⊔ UnboxResult ParseNull "null hello world" (∘)
⍤ "parsing anything else doesnt fail" ⍣(0 UnboxResult ParseNull "true hello world" (∘))(1)
~~~

# OBJECT <- STRING PARSER
ParseNumber ← |2 ?(BoxResult ⊙↘ parse ↙ ⊙, . ⊗0 + ⊙∶ =⇡⧻ ∶ ⊗ @. .. ∶) (0 ⍤ . $"Invalid JSON failed to parse at _" ;) = 0 ⊗ 1 . ∵(∊ ∶ "0123456789") . ;∶
~~~
⍤ "parsing integers fails" ↧ ⊙(≅ " test") = 123 UnboxResult ParseNumber "123 test" (∘)
⍤ "parsing floats fails" ↧ ⊙(≅ " test") = 123.45 UnboxResult ParseNumber "123.45 test" (∘)
⍤ "parsing anything else doesnt fail" ⍣(0 UnboxResult ParseNumber "hello world" (∘))(1)
~~~

ParseJsonRaw ← |1 SelfApply (|2 
  ?(0 ⍤ . $"Invalid JSON failed to parse _" ;∶)(
    ! ⊡ ∶ [(ParseObject)
           (ParseArray)
           (ParseString)
           (ParseTrue)
           (ParseFalse)
           (ParseNull)
           (ParseNumber)] ⊗ ∶ "{[\"tfn" ⊡ 0 .
  ) =0 ⧻. Trim ∶
)
~~~
⍤ "parsing empty array fails" ↧ ⊙(≅ " empty") ≅ [] UnboxResult ParseJsonRaw "[] empty"
⍤ "parsing singleton array fails" ↧ ⊙(≅ " empty") ↧ =1 ⊔⊡0 ∶ =1 ⧻. UnboxResult ParseJsonRaw "[1] empty"
⍤ "parsing multiple type array fails" ↧ ⊙(≅ " empty") ↧ ≅ "test" ⊔⊡2 ∶ ↧ =0 ⊔⊡1 ∶ ↧ =1 ⊔⊡0 ∶ =3 ⧻... UnboxResult ParseJsonRaw "[1, false, \"test\"] empty"
⍤ "parsing empty object fails" ↧ ⊙(≅ " empty") ≅ [] ⊔ UnboxResult ParseJsonRaw "{} empty"
⍤ "parsing singleton object fails" ↧ ⊙(≅ " empty") ObjectsEqual ⍉[{"a" 3}] UnboxResult ParseJsonRaw "{ \"a\": 3 } empty"
⍤ "parsing multiple type object fails" ↧ ⊙(≅ " empty") ObjectsEqual ⍉[{"a" 3} {"b" 0} {"c" "test"}] UnboxResult ParseJsonRaw "{ \"a\": 3, \"b\": false, \"c\": \"test\" } empty"
⍤ "parsing object nested in array fails" ↧ ⊙(≅ " empty") ↧ ObjectsEqual ⍉[{"a" 2}] ⊔ ⊡ 0 ∶ =1 ⧻. UnboxResult ParseJsonRaw "[{ \"a\": 2 }] empty"
⍤ "parsing arrays nested in objects fails" ↧ ⊙(≅ " empty") ≅ 1_2_3 ∵⊔ ⊔GetKey "a" UnboxResult ParseJsonRaw "{ \"a\": [1, 2, 3] } empty"
~~~

ParseJson ← ⊔ ⊡ 0 ParseJsonRaw

ParseJson "{}"

[(ParseJson)]
