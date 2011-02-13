{- | 
This Fungen module controls the user input (mouse, keyboard, joystick...)
-}
{- 

FunGEN - Functional Game Engine
http://www.cin.ufpe.br/~haskell/fungen
Copyright (C) 2002  Andre Furtado <awbf@cin.ufpe.br>

This code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

-}

module Graphics.UI.Fungen.Input (
        InputConfig,
        Key(..), KeyEvent(..), SpecialKey(..), MouseButton(..),
        funBinding
) where

import Graphics.UI.Fungen.Game
import Graphics.UI.Fungen.UserInput
import Graphics.UI.GLUT

type InputConfig t s u v = (Key,KeyEvent,IOGame t s u v ())

funBinding :: [InputConfig t s u v] -> Game t s u v -> IO (KeyBinder, StillDownHandler)
funBinding inputs g = do
        (bindKey, stillDown) <- initUserInput
        mapM (userBinding g bindKey) inputs 
        return (bindKey, stillDown)

userBinding :: Game t s u v -> KeyBinder -> InputConfig t s u v -> IO ()
userBinding g bindKey (key,keyEvent,gameAction) = bindKey key keyEvent (Just (runIOGameM gameAction g))