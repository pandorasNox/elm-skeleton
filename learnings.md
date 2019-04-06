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

- you can read the colon as "has the type" So `update` has the type `Msg -> Model -> Model`. `->`  in a type says that it is a function

- the main function
    - type signature `main : Program Never Model Msg` or `main : Program () Model Msg`
        - resource: https://package.elm-lang.org/packages/elm/core/latest/Platform
        - says:
            - is return type
            - type with 3 type variables `type Program flags model msg`

#### resources
- https://github.com/elm-guides/elm-for-js/blob/master/How%20to%20Read%20a%20Type%20Annotation.md
