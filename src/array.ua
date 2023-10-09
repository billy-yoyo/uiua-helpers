# NEW_ARRAY <- INDEX VALUE ARRAY
ReplaceIndex ← ⊙; ⊂⊂ ⊙∶ ⊙(↘+1) ↙⊙,.⊙,
~~~
⍤ "replacing first element fails" ≅ 9_2_3 ReplaceIndex 0 9 1_2_3
⍤ "replacing middle element fails" ≅ 1_9_3 ReplaceIndex 1 9 1_2_3
⍤ "replacing last element fails" ≅ 1_2_9 ReplaceIndex 2 9 1_2_3
⍤ "replacing singleton array element fails" ≅ [9] ReplaceIndex 0 9 [1]
~~~

# NEW_ARRAY <- INDEX ARRAY
DeleteIndex ← ⊂ ⊙(↘+1) ↙ ,,
~~~
⍤ "deleting first element fails" ≅ 2_3 DeleteIndex 0 1_2_3
⍤ "deleting middle element fails" ≅ 1_3 DeleteIndex 1 1_2_3
⍤ "deleting last element fails" ≅ 1_2 DeleteIndex 2 1_2_3
⍤ "deleting singleton array element fails" ≅ [] DeleteIndex 0 [1]
~~~

ReplaceIndex_DeleteIndex

~~~
ReplaceIndex_DeleteIndex
~~~
