gdual
=====

Generic Dual numbers

Prelude> :load Math.GDual.Demo.SimpleSparseSolver
[1 of 1] Compiling Math.GDual.Demo.SimpleSparseSolver ( Math/GDual/Demo/SimpleSparseSolver.hs, interpreted )
Ok, modules loaded: Math.GDual.Demo.SimpleSparseSolver.
*Math.GDual.Demo.SimpleSparseSolver> :load Math.GDual
Ok, modules loaded: Math.GDual.
Prelude Math.GDual> :add Math.GDual.Demo.SimpleSparseSolver
[2 of 2] Compiling Math.GDual.Demo.SimpleSparseSolver ( Math/GDual/Demo/SimpleSparseSolver.hs, interpreted )
Ok, modules loaded: Math.GDual.Demo.SimpleSparseSolver, Math.GDual.
*Math.GDual.Demo.SimpleSparseSolver> import Math.GDual
*Math.GDual.Demo.SimpleSparseSolver Math.GDual> solve [[(0,1 :+- [1,0,0,0]),(1,2 :+- [0,1,0,0]),(2,3)],[(0,1 :+- [0,0,1,0]),(1,1 :+- [0,0,0,1]),(2,1)]]
Loading package array-0.4.0.1 ... linking ... done.
....
Loading package linear-1.10.1.1 ... linking ... done.
[[(2,-1.0+ε[-1.0,2.0,2.0,-4.0])],[(2,2.0+ε[1.0,-2.0,-1.0,2.0])]]

*Math.GDual.Demo.SimpleSparseSolver Math.GDual> import Linear
*Math.GDual.Demo.SimpleSparseSolver Math.GDual Linear> inv22 $ V2 (V2 (1 :+- [1,0,0,0]) (2 :+- [0,1,0,0])) (V2 (1 :+- [0,0,1,0]) (1 :+- [0,0,0,1]))
Just (V2 (V2 -1.0+ε[-1.0,1.0,2.0,-2.0] 2.0+ε[2.0,-1.0,-4.0,2.0]) (V2 1.0+ε[1.0,-1.0,-1.0,1.0] -1.0+ε[-2.0,1.0,2.0,-1.0]))
