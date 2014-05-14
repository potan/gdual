{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE UndecidableInstances #-}
module Math.GDual(GDual(..)) where

import Linear.Vector
import Linear.Epsilon
-- import Control.Applicative

data GDual n v = !n :+- (v n) deriving Eq

instance (Show n, Show (v n)) => Show (GDual n v) where
 show (x :+- y) = show x ++ "+\949" ++ show y

instance (Eq n, Num n, Additive v) => Num (GDual n v) where
 fromInteger x = (fromInteger x) :+- zero
 (x1 :+- y1) + (x2 :+- y2) = (x1 + x2) :+- (y1 ^+^ y2)
 (x1 :+- y1) - (x2 :+- y2) = (x1 - x2) :+- (y1 ^-^ y2)
 (x1 :+- y1) * (x2 :+- y2) = (x1 * x2) :+- ((y1 ^* x2) ^+^ (x1 *^ y2))
 negate (x :+- y) = (negate x) :+- (y ^* (-1))
 abs (a@(x :+- y)) = case (signum x) of
                      0 -> 0 :+- fmap abs y
                      z -> ((z * x) :+- (x *^ y))
 signum (x :+- y) = case (signum x) of
                      0 -> 0 :+- fmap signum y
                      z -> z :+- zero

instance (Num (GDual n v), Fractional n, Additive v) => Fractional (GDual n v) where
 (x1 :+- y1) / (x2 :+- y2) = (x1 / x2) :+- ((y1 ^/ x2) ^-^
                                                      ((x1 / (x2 * x2)) *^ y2))
 recip (x :+- y) =  (recip x) :+- (y ^/ (x * x))
 fromRational x = (fromRational x) :+- zero

instance (Fractional (GDual n v), Floating n, Additive v) => Floating (GDual n v) where
  pi = pi :+- zero
  sin (x :+- y) = (sin x) :+- (cos x *^ y)
  cos (x :+- y) = (cos x) :+- ((negate $ sin x) *^ y)
  exp (x :+- y) = let r = exp x in r :+- (r *^ y)
  log (x :+- y) = (log x) :+- (y ^/ x)
  sinh (x :+- y) = (sinh x) :+- (cosh x *^ y)
  cosh (x :+- y) = (cosh x) :+- (sinh x *^ y)
  asin (x :+- y) = (asin x) :+- (y ^/ sqrt(1.0 - (x * x)))
  acos (x :+- y) = (acos x) :+- (y ^/ (negate $ sqrt(1.0 - (x * x))))
  atan (x :+- y) = (atan x) :+- (y ^* (1.0 + (x * x)))
  asinh (x :+- y) = (asinh x) :+- (y ^/ sqrt(1.0 + (x * x)))
  acosh (x :+- y) = (acosh x) :+- (y ^/ (negate $ sqrt(1.0 + (x * x))))
  atanh (x :+- y) = (atanh x) :+- (y ^* (1.0 - (x * x)))
  sqrt (x :+- y) = let r = sqrt x in r :+- (y ^/ (2.0 * r))
  

instance (Num (GDual n v), Epsilon n) => Epsilon (GDual n v) where
 nearZero (x :+- _) = nearZero x
