
module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (Html, div, text, input, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : Int
    }


init : Model
init =
    Model "" "" "" 0



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Dosubmit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = (String.toInt age |> Maybe.withDefault 0) }

        Dosubmit ->
            model


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "number" "How old are you?" (String.fromInt model.age) Age
        , viewValidation model
        , button [ onClick Dosubmit ] [ text "submit" ]
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "password to short" ]

    else if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "red" ] [ text "Passwords do not match!" ]
