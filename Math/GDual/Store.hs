{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE UndecidableInstances #-}
module Math.GDual.Store where

import Math.GDual

import Foreign.Ptr
import Foreign.Storable
import Foreign.Storable.Tuple

instance (Storable n, Storable (v n)) => Storable (GDual n v) where
 sizeOf (x :+- y) = sizeOf (x,y)
 alignment (x :+- y) = alignment (x,y)
 peekElemOff p i = fmap (\(x,y) -> (x :+- y)) $ peekElemOff (castPtr p) i
 pokeElemOff p i (x :+- y) = pokeElemOff (castPtr p) i (x,y)
