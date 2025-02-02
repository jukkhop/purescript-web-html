module Web.HTML.Window
  ( Window
  , toEventTarget
  , document
  , navigator
  , location
  , history
  , innerWidth
  , innerHeight
  , alert
  , confirm
  , moveBy
  , moveTo
  , open
  , outerHeight
  , outerWidth
  , print
  , prompt
  , promptDefault
  , resizeBy
  , resizeTo
  , screenX
  , screenY
  , scroll
  , scrollBy
  , scrollX
  , scrollY
  , localStorage
  , sessionStorage
  , requestAnimationFrame
  , cancelAnimationFrame
  , RequestAnimationFrameId
  , requestIdleCallback
  , cancelIdleCallback
  , RequestIdleCallbackId
  , parent
  , opener
  , performance
  ) where

import Data.Maybe (Maybe)
import Data.Newtype (class Newtype, unwrap)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Prelude (class Eq, class Ord, Unit, (<$>), (<<<), map)
import Unsafe.Coerce (unsafeCoerce)
import Web.Event.EventTarget (EventTarget)
import Web.HTML.HTMLDocument (HTMLDocument)
import Web.HTML.History (History)
import Web.HTML.Location (Location)
import Web.HTML.Navigator (Navigator)
import Web.Performance (Performance)
import Web.Storage.Storage (Storage)

foreign import data Window :: Type

toEventTarget :: Window -> EventTarget
toEventTarget = unsafeCoerce

foreign import document :: Window -> Effect HTMLDocument

foreign import navigator :: Window -> Effect Navigator

foreign import location :: Window -> Effect Location

foreign import history :: Window -> Effect History

foreign import innerWidth :: Window -> Effect Int

foreign import innerHeight :: Window -> Effect Int

foreign import alert :: String -> Window -> Effect Unit

foreign import confirm :: String -> Window -> Effect Boolean

foreign import moveBy :: Int -> Int -> Window -> Effect Unit

foreign import moveTo :: Int -> Int -> Window -> Effect Unit

open :: String -> String -> String -> Window -> Effect (Maybe Window)
open url' name features window = toMaybe <$> _open url' name features window

foreign import _open
  :: String
  -> String
  -> String
  -> Window
  -> Effect (Nullable Window)

foreign import outerHeight :: Window -> Effect Int

foreign import outerWidth :: Window -> Effect Int

foreign import print :: Window -> Effect Unit

prompt :: String -> Window -> Effect (Maybe String)
prompt msg window = toMaybe <$> _prompt msg "" window

promptDefault :: String -> String -> Window -> Effect (Maybe String)
promptDefault msg defaultText window = toMaybe <$> _prompt msg defaultText window

foreign import _prompt :: String -> String -> Window -> Effect (Nullable String)

foreign import resizeBy :: Int -> Int -> Window -> Effect Unit

foreign import resizeTo :: Int -> Int -> Window -> Effect Unit

foreign import screenX :: Window -> Effect Int

foreign import screenY :: Window -> Effect Int

foreign import scroll :: Int -> Int -> Window -> Effect Unit

foreign import scrollBy :: Int -> Int -> Window -> Effect Unit

foreign import scrollX :: Window -> Effect Int

foreign import scrollY :: Window -> Effect Int

foreign import localStorage :: Window -> Effect Storage

foreign import sessionStorage :: Window -> Effect Storage

newtype RequestAnimationFrameId = RequestAnimationFrameId Int

derive instance newtypeRequestAnimationFrameId :: Newtype RequestAnimationFrameId _
derive instance eqRequestAnimationFrameId :: Eq RequestAnimationFrameId
derive instance ordRequestAnimationFrameId :: Ord RequestAnimationFrameId

foreign import _requestAnimationFrame :: Effect Unit -> Window -> Effect Int

requestAnimationFrame :: Effect Unit -> Window -> Effect RequestAnimationFrameId
requestAnimationFrame fn = map RequestAnimationFrameId <<< _requestAnimationFrame fn

foreign import _cancelAnimationFrame :: Int -> Window -> Effect Unit

cancelAnimationFrame :: RequestAnimationFrameId -> Window -> Effect Unit
cancelAnimationFrame idAF = _cancelAnimationFrame (unwrap idAF)

newtype RequestIdleCallbackId = RequestIdleCallbackId Int

derive instance newtypeRequestIdleCallbackId :: Newtype RequestIdleCallbackId _
derive instance eqRequestIdleCallbackId :: Eq RequestIdleCallbackId
derive instance ordRequestIdleCallbackId :: Ord RequestIdleCallbackId

foreign import _requestIdleCallback :: { timeout :: Int } -> Effect Unit -> Window -> Effect Int

-- | Set timeout to `0` to get the same behaviour as when it is `undefined` in
-- | [JavaScript](https://w3c.github.io/requestidlecallback/#h-the-requestidle-callback-method).
requestIdleCallback :: { timeout :: Int } -> Effect Unit -> Window -> Effect RequestIdleCallbackId
requestIdleCallback opts fn = map RequestIdleCallbackId <<< _requestIdleCallback opts fn

foreign import _cancelIdleCallback :: Int -> Window -> Effect Unit

cancelIdleCallback :: RequestIdleCallbackId -> Window -> Effect Unit
cancelIdleCallback idAF = _cancelIdleCallback (unwrap idAF)

foreign import parent :: Window -> Effect Window

foreign import _opener :: Window -> Effect (Nullable Window)

opener :: Window -> Effect (Maybe Window)
opener window = toMaybe <$> _opener window

foreign import _performance :: Window -> Effect (Nullable Performance)

performance :: Window -> Effect (Maybe Performance)
performance window = toMaybe <$> _performance window
