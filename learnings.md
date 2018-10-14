# learnings

## elm 0.19
- "syntax intention" on the example of modulo
    - in JS `11 % 4 === 3` returns `true`
    - in elm it looks like `(11 |> modBy 4) == 3` returns `True : Bool`

- cast a string to an int (and handle the `error` respectively the `maybe`)
    - elm short `age = (String.toInt age |> Maybe.withDefault 0)`
    - long (but probbably better)
        ```
            case String.toInt "foo" of \
                Maybe.Nothing -> \
                    0 \
                Maybe.Just val -> \
                    val
        ```

        `Maybe.Nothing` or just `Nothing` seems to work both

        ```
            case String.toInt "15" of \
                Nothing -> \
                    0 \
                Just val -> \
                    val
        ```
