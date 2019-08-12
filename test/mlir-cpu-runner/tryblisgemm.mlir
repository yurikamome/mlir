func @packA(%oribuf : !linalg.view<?x?x?x?x?x?x?xf64>){
     %c768 = constant 768 : index

     %Tm0 = constant 6 : index
     %Tn0 = constant 8 : index
     
     %Tk1 = constant 256 : index
     %Tm1 = constant 6 : index
     %Tn1 = constant 8 : index

     %Tk2 = constant 256 : index
     %Tm2 = constant 96 : index
     %Tn2 = constant 8 : index
     
     %Tk3 = constant 256 : index
     %Tm3 = constant 96 : index
     %Tn3 = constant 768 : index

     %c1 = constant 1 : index
     %c0 = constant 0 : index


     %i0 = linalg.range %c0:%Tm0:%c1 : !linalg.range
     %j0 = linalg.range %c0:%Tn0:%c1 : !linalg.range



     %Rgm1 = divis %Tm1, %Tm0 : index
     %Rgn1 = divis %Tn1, %Tn0 : index
     
     %k1 = linalg.range %c0:%Tk1:%c1  : !linalg.range
     %i1 = linalg.range %c0:%Rgm1:%c1 : !linalg.range
     %j1 = linalg.range %c0:%Rgn1:%c1 : !linalg.range

     %Rgk2 = divis %Tk2, %Tk1 : index
     %Rgm2 = divis %Tm2, %Tm1 : index
     %Rgn2 = divis %Tn2, %Tn1 : index    

     %k2 = linalg.range %c0:%Rgk2:%c1 : !linalg.range
     %i2 = linalg.range %c0:%Rgm2:%c1 : !linalg.range
     %j2 = linalg.range %c0:%Rgn2:%c1 : !linalg.range

     %Rgk3 = divis %Tk3, %Tk2 : index
     %Rgm3 = divis %Tm3, %Tm2 : index
     %Rgn3 = divis %Tn3, %Tn2 : index     

     %k3 = linalg.range %c0:%Rgk3:%c1 : !linalg.range
     %i3 = linalg.range %c0:%Rgm3:%c1 : !linalg.range
     %j3 = linalg.range %c0:%Rgn3:%c1 : !linalg.range

     %Rgk4 = divis %c768, %Tk3 : index
     %Rgm4 = divis %c768, %Tm3 : index
     %Rgn4 = divis %c768, %Tn3 : index     

     %k4 = linalg.range %c0:%Rgk4:%c1 : !linalg.range
     %i4 = linalg.range %c0:%Rgm4:%c1 : !linalg.range
     %j4 = linalg.range %c0:%Rgn4:%c1 : !linalg.range

    // buffer size : A tile in L3 = Tm3 x Tk3 = 96x256 = 24576
     %outbuf = linalg.buffer_alloc : !linalg.buffer<24576xf64>
     %outview = linalg.view %outbuf[%i3, %i2, %i1, %i0, %k3, %k2, %k1] :!linalg.buffer<24576xf64>-> !linalg.view<?x?x?x?x?x?x?xf64>
     
     linalg.copy(%oribuf, %outview){inputPermutation = (a3,a2,a1,a0,b3,b2,b1) -> (a3,a2,a1,a0,b3,b2,b1),
     outputPermutation = (a3,a2,a1,a0,b3,b2,b1) -> (b3,a3,b2,a2,a1,b1,a0)
     } : !linalg.view<?x?x?x?x?x?x?xf64>,  !linalg.view<?x?x?x?x?x?x?xf64>
     
return %outview : !linalg.view<?x?x?x?x?x?x?xf64>
}

func @packB(%oribuf : !linalg.view<?x?x?x?x?x?x?xf64>){
     %c768 = constant 768 : index

     %Tm0 = constant 6 : index
     %Tn0 = constant 8 : index
     
     %Tk1 = constant 256 : index
     %Tm1 = constant 6 : index
     %Tn1 = constant 8 : index

     %Tk2 = constant 256 : index
     %Tm2 = constant 96 : index
     %Tn2 = constant 8 : index
     
     %Tk3 = constant 256 : index
     %Tm3 = constant 96 : index
     %Tn3 = constant 768 : index

     %c1 = constant 1 : index
     %c0 = constant 0 : index


     %i0 = linalg.range %c0:%Tm0:%c1 : !linalg.range
     %j0 = linalg.range %c0:%Tn0:%c1 : !linalg.range



     %Rgm1 = divis %Tm1, %Tm0 : index
     %Rgn1 = divis %Tn1, %Tn0 : index     
     
     %k1 = linalg.range %c0:%Tk1:%c1 : !linalg.range
     %i1 = linalg.range %c0:%Rgm1:%c1 : !linalg.range
     %j1 = linalg.range %c0:%Rgn1:%c1 : !linalg.range

     %Rgk2 = divis %Tk2, %Tk1 : index
     %Rgm2 = divis %Tm2, %Tm1 : index
     %Rgn2 = divis %Tn2, %Tn1 : index     

     %k2 = linalg.range %c0:%Rgk2:%c1 : !linalg.range
     %i2 = linalg.range %c0:%Rgm2:%c1 : !linalg.range
     %j2 = linalg.range %c0:%Rgn2:%c1 : !linalg.range

     %Rgk3 = divis %Tk3, %Tk2 : index
     %Rgm3 = divis %Tm3, %Tm2 : index
     %Rgn3 = divis %Tn3, %Tn2 : index     

     %k3 = linalg.range %c0:%Rgk3:%c1 : !linalg.range
     %i3 = linalg.range %c0:%Rgm3:%c1 : !linalg.range
     %j3 = linalg.range %c0:%Rgn3:%c1 : !linalg.range

     %Rgk4 = divis %c768, %Tk3 : index
     %Rgm4 = divis %c768, %Tm3 : index
     %Rgn4 = divis %c768, %Tn3 : index     

     %k4 = linalg.range %c0:%Rgk4:%c1 : !linalg.range
     %i4 = linalg.range %c0:%Rgm4:%c1 : !linalg.range
     %j4 = linalg.range %c0:%Rgn4:%c1 : !linalg.range

    // buffer size : B tile in L3 = Tn3 x Tk3 = 768*256 = 196608
     %outbuf = linalg.buffer_alloc : !linalg.buffer<196608xf64>
     %outview = linalg.view %outbuf[%j3, %j2, %j1, %j0, %k3, %k2, %k1] : !linalg.buffer<196608xf64>-> !linalg.view<?x?x?x?x?x?x?xf64>
     linalg.copy(%oribuf, %outview){inputPermutation = (a3,a2,a1,a0,b3,b2,b1) -> (a3,a2,a1,a0,b3,b2,b1),
     outputPermutation = (a3,a2,a1,a0,b3,b2,b1) -> (b3,a3,b2,a2,a1,b1,a0)
     } : !linalg.view<?x?x?x?x?x?x?xf64> , !linalg.view<?x?x?x?x?x?x?xf64>
     
return %outview : !linalg.view<?x?x?x?x?x?x?xf64>
}









//768 x 768 = 589824
func @tilegemm(%argA: !linalg.buffer<589824xf64>,
     %argB: !linalg.buffer<589824xf64>, %argC: !linalg.buffer<589824xf64>){

     %c768 = constant 768 : index

     %Tm0 = constant 6 : index
     %Tn0 = constant 8 : index
     
     %Tk1 = constant 256 : index
     %Tm1 = constant 6 : index
     %Tn1 = constant 8 : index

     %Tk2 = constant 256 : index
     %Tm2 = constant 96 : index
     %Tn2 = constant 8 : index
     
     %Tk3 = constant 256 : index
     %Tm3 = constant 96 : index
     %Tn3 = constant 768 : index

     %c1 = constant 1 : index
     %c0 = constant 0 : index
     
// Tk4 = Tn4 = Tm4 = problem size = 768

//A : m x k = 768 x 768 ->  set of A buffers 96 x 256

//A: Nm x Nk  = (Nm/Tm3) x (Tm3/Tm2) x (Tm2/Tm1) x (Tm1/Tm0) x Tm0  x  (Nk/Tk3) x (Tk3/Tk2) x (Tk2/Tk1) x (Tk1)

     %i0 = linalg.range %c0:%Tm0:%c1 : !linalg.range
     %j0 = linalg.range %c0:%Tn0:%c1 : !linalg.range



     %Rgm1 = divis %Tm1, %Tm0 : index
     %Rgn1 = divis %Tn1, %Tn0 : index    
     
     %k1 = linalg.range %c0:%Tk1:%c1 : !linalg.range
     %i1 = linalg.range %c0:%Rgm1:%c1 : !linalg.range
     %j1 = linalg.range %c0:%Rgn1:%c1 : !linalg.range

     %Rgk2 = divis %Tk2, %Tk1 : index
     %Rgm2 = divis %Tm2, %Tm1 : index
     %Rgn2 = divis %Tn2, %Tn1 : index     

     %k2 = linalg.range %c0:%Rgk2:%c1 : !linalg.range
     %i2 = linalg.range %c0:%Rgm2:%c1 : !linalg.range
     %j2 = linalg.range %c0:%Rgn2:%c1 : !linalg.range

     %Rgk3 = divis %Tk3, %Tk2 : index
     %Rgm3 = divis %Tm3, %Tm2 : index
     %Rgn3 = divis %Tn3, %Tn2 : index     

     %k3 = linalg.range %c0:%Rgk3:%c1 : !linalg.range
     %i3 = linalg.range %c0:%Rgm3:%c1 : !linalg.range
     %j3 = linalg.range %c0:%Rgn3:%c1 : !linalg.range

     %Rgk4 = divis %c768, %Tk3 : index
     %Rgm4 = divis %c768, %Tm3 : index
     %Rgn4 = divis %c768, %Tn3 : index     

     %k4 = linalg.range %c0:%Rgk4:%c1 : !linalg.range
     %i4 = linalg.range %c0:%Rgm4:%c1 : !linalg.range
     %j4 = linalg.range %c0:%Rgn4:%c1 : !linalg.range
     
     

     %Aori = linalg.view %argA[%i4, %i3, %i2, %i1, %i0, %k4, %k3, %k2, %k1] : !linalg.buffer<589824xf64> -> !linalg.view<?x?x?x?x?x?x?x?x?xf64> 

     %Bori = linalg.view %argB[%j4, %j3, %j2, %j1, %j0, %k4, %k3, %k2, %k1] :  !linalg.buffer<589824xf64> -> !linalg.view<?x?x?x?x?x?x?x?x?xf64>

     %Cori = linalg.view %argC[%i4, %i3, %i2, %i1, %i0, %j4, %j3, %j2, %j1, %j0] :  !linalg.buffer<589824xf64> -> !linalg.view<?x?x?x?x?x?x?x?x?x?xf64>

     loop.for %lpk4 = %c0 to %Rgk4 step %c1 {
     loop.for %lpn4 = %c0 to %Rgn4 step %c1 {
     %Bori_L3 = linalg.slice %Bori[%lpj4, %j3, %j2, %j1, %j0, %lpk4, %k3 ,%k2, %k1] : !linalg.view<?x?x?x?x?x?x?x?x?xf64>, index, !linalg.range, !linalg.range, !linalg.range, !linalg.range, index, !linalg.range, !linalg.range, !linalg.range, !linalg.view<?x?x?x?x?x?x?xf64>
     %Bbuf_L3 = call @packB(%Bori_L3) : (!linalg.view<?x?x?x?x?x?x?xf64>) -> (!linalg.view<?x?x?x?x?x?x?xf64>)
     
     loop.for %lpm4 = %c0 to %Rgm4 step %c1 {

     %Aori_L3 = linalg.slice %Aori[%lpm4, %i3, %i2, %i1, %i0, %lpk4, %k3, %k2, %k1] : !linalg.view<?x?x?x?x?x?x?x?x?xf64>, index, !linalg.range, !linalg.range, !linalg.range, !linalg.range, index, !linalg.range, !linalg.range, !linalg.range, !linalg.view<?x?x?x?x?x?x?xf64>
     
     %Abuf_L3 = call @packA(%Aori_L3) : (!linalg.view<?x?x?x?x?x?x?xf64>) -> (!linalg.view<?x?x?x?x?x?x?xf64>)
     
     loop.for %lpk3 = %c0 to %Rgk3 step %c1 {
     loop.for %lpm3 = %c0 to %Rgm3 step %c1 {
     loop.for %lpn3 = %c0 to %Rgn3 step %c1 {
     
     loop.for %lpk2 = %c0 to %Rgk2 step %c1 {
     loop.for %lpn2 = %c0 to %Rgn2 step %c1 {
     loop.for %lpm2 = %c0 to %Rgm2 step %c1 {


     loop.for %lpn1 = %c0 to %Rgn2 step %c1 {
     loop.for %lpm1 = %c0 to %Rgm2 step %c1 {
//     loop.for %lpk1 = %c0 to %Rgk2 step %c1 {
       %ukrA = linalg.slice %Abuf_L3[%lpk3, %lpm3, %lpk2, %lpm2, %lpm1, %k1, %i0] : !linalg.view<?x?x?x?x?x?x?xf64>, index, index, index, index, index, !linalg.range, !linalg.range, !linalg.view<?x?xf64>
       %ukrB = linalg.slice %Bbuf_L3[%lpk3, %lpn3, %lpk2, %lpn2, %lpn1, %k1, %j0] : !linalg.view<?x?x?x?x?x?x?xf64>, index, index, index, index, index, !linalg.range, !linalg.range, !linalg.view<?x?xf64>
       %ukrC = linalg.slice %Cori[%lpm4, %lpm3, %lpm2, %lpm1, %i0, %lpn4, %lpn3, %lpn2, %lpn1, %j0] : !linalg.view<?x?x?x?x?x?x?x?x?x?xf64>, index, index, index, index, !linalg.range, index, index, index, index, !linalg.range, !linalg.view<?x?xf64>
       
//       linalg.blisukr(%ukrA, %ukrB, %ukrC)
         linalg.matmul(%ukrA, %ukrB, %ukrC) : !linalg.view<?x?xf64>, !linalg.view<?x?xf64>, !linalg.view<?x?xf64>

//     }
     }
     }     

     }
     }
     }     

     }
     }
     }     

     }
     }
     }

     
     
     return
}