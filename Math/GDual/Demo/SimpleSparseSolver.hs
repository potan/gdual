module Math.GDual.Demo.SimpleSparseSolver (solve) where

import Linear.Epsilon

zm c = z where
  z [] a = a
  z a [] = map (\(n,v) -> (n,c*v)) a
  z (xl@((nx,x):xs)) (yl@((ny,y):ys)) | nx == ny = (let r = (z xs ys)
                                                        v = y+c*x
                                                    in
                                                        if nearZero v
                                                        then r
                                                        else (nx, v):r)
                                      | nx < ny = (nx,c*x):(z xs yl)
                                      | True    = (ny,y):(z xl ys)
  
kill1 _ [] l = l
kill1 (n,v) x y =
    case filter ((n ==) . fst) y of
     [] -> y
     ((_,vy):_) -> zm (negate (vy/v)) x y

diag l [] = reverse l
diag l (x:xs) = let
    (v:_) = filter (not . nearZero . snd) x
    k = kill1 v x
  in diag (x:(map k l)) (map k xs)

solve l = map (\((_,d):s) -> map (\(n,v) -> (n,v/d)) s) $ diag [] l
