

module Counter exposing(main)

import Browser
import Html exposing (Html, text)
import Html.Events exposing (onClick)
import Css
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events


-- MODEL


type alias Model = Int

init : Model
init =
    0


-- UPDATE


type Msg = Increase | Decrease | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increase ->
            model + 1

        Decrease ->
            model - 1

        Reset ->
            0


-- VIEW


-- view : Model -> Html Msg
-- view model =
--     Html.div []
--         [ Html.button [ onClick Increase ] [ text "+" ]
--         , Html.button [ onClick Decrease ] [ text "-" ]
--         , Html.div []
--             [ text (String.fromInt model) ]
--         , Html.div [] []
--         , Html.button [ onClick Reset ] [ text "Reset" ]
--         ]


view : Model -> Html Msg
view model =
    Html.Styled.div []
        [ btn [ Html.Styled.Events.onClick Increase ] [ Html.Styled.text "+" ]
        , btn [ Html.Styled.Events.onClick Decrease ] [ Html.Styled.text "-" ]
        , Html.Styled.div []
            [ Html.Styled.text (String.fromInt model) ]
        , Html.Styled.div [] []
        , btn [ Html.Styled.Events.onClick Reset ] [ Html.Styled.text "Reset" ]
        ]
    |> Html.Styled.toUnstyled


btn : List (Html.Styled.Attribute msg) 
    -> List (Html.Styled.Html msg)
    -> Html.Styled.Html msg
btn =
    Html.Styled.styled
        Html.Styled.button
        [Css.margin (Css.px 12)]


-- subscriptions


-- MAIN


-- main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

