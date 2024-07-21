// * Discription what the *.scad is about ect.

// ==================================
// = Used Libraries =
// ==================================

// ==================================
// = Variables =
// ==================================

/* [Tab Name_1] */
// sizing printing or print a small part to test the object.
DesignStatus="sizing"; // ["sizing","fitting","printing"]
// Variables seen by customizer

HeightBaseSchape=50;
WidthBaseSchape=60;
Thicknes=12;

OutstandRest_Height=100;
OutstandRest_Width=55;
OutStand=105;
OutStand_UpRise=20;

Pipe_D=5.9;
Pipe_R_Offset=3;

TestSlab_X=50;
TestSlab_Y=100;
TestSlab_Z=30;

/* [Tab Name_2] */
TestCylinder_H=35;
TestCylinder_D1=25;
TestCylinder_D2=45;

TestSphere_D=42;

module __Customizer_Limit__ () {}  // before these, the variables are usable in the cutomizer
shown_by_customizer = false;


Circle_D=Pipe_D+Pipe_R_Offset;

Invisible=42;
TestslabTransl_X=25;
TestslabRotate_X=30;

// === Facettes Numbers ===

FN_HexNut=6;
FN_Performance=36;
FN_FooBaa=12;
// Divisebile by 4 to align Cylinders whithout small intersections taht cause problems due to smal holes in surfaches and self intersections on round objects

FN_Rough=12;
FN_MediumRough=16;
FN_Medium=36;
FN_Fine=72;
FN_ExtraFine=144;
// ==================================
// = Tuning Variables =
// ==================================
// Variables for finetuning (The Slegehammer if something has to be made fit)

// ==================================
// = Customizer Section =
// ==================================
if (DesignStatus=="printing"){
    Main_Assembly(36,76,"false");
    mirror([0,1,0]){
        translate([0,1,0]){
            Main_Assembly(36,76,"false");}
        }
}
if(DesignStatus=="fitting"){
    intersection(){                                 // Flat Shape
        translate([0,0,0]){
            #cube([1000,1000,0.4],center=true);
        }
        Main_Assembly(16,76,"false");
    }
    intersection(){                                 // Flat Shape
        translate([OutstandRest_Width,OutstandRest_Height,0]){
            rotate([0,0,300]){
                #cube([45,20,30],center=true);
            }
        }
        Main_Assembly(16,76,"false");
    }
}
if (DesignStatus=="sizing"){
    Main_Assembly(16,36,"true");
}
// ==================================
// = MAINASSEMBLY =
// ==================================
// LOW_RESOLUTION: low reaulution value to speed up preview
// HIGH_RESOLUTION: high resolution value for rendering the .stl
// CUT_MODULES_RENDERED: decides if the cuttingmodules get renderred to see them. use cuttingmodules twice one time within the final part to cut and one time to just schow it.
// Main_Assembly(12,76,true);
module Main_Assembly(LOW_RESOLUTION=12,HIGH_RESOLUTION=36,CUT_MODULES_RENDERED){
$fn = $preview ? LOW_RESOLUTION : HIGH_RESOLUTION ; // Facets in preview (F5) set to 12, in Reder (F6) is set to 36 "as default" or else if variable contians a value
    see_me_in_colourful(){
        translate([0,0,0]){
            difference(){
                LinExtr_Base_Shape_Poligon();
                translate([Thicknes,0,10]){
                    Round_CUTTER(300,20);                
                }
                translate([0,0,Thicknes*2-Thicknes/2]){
                    translate([Thicknes-Thicknes/3,Thicknes/2,0]){
                        rotate([0,-90,0]){
                            #Screwcutter();
                        }
                    }
                    translate([Thicknes-Thicknes/3,HeightBaseSchape+Thicknes/2,0]){
                        rotate([0,-90,0]){
                            #Screwcutter();
                        }
                    }
                }
            }
        }
        translate([0,0,0]){
            
        }        
        translate([0,0,0]){
            difference(){
                //TEST_SPHERE();
                
            }
        }
        translate([0,0,0]){
            
        }
        translate([0,0,0]){
            if(CUT_MODULES_RENDERED=="true"){
                translate([Thicknes,0,10]){
                    //Round_CUTTER(300,20);                
                }
                translate([0,0,Thicknes*2-Thicknes/2]){
                    translate([Thicknes-Thicknes/3,Thicknes/2,0]){
                        rotate([0,-90,0]){
                            #Screwcutter();
                        }
                    }
                    translate([Thicknes-Thicknes/3,HeightBaseSchape+Thicknes/2,0]){
                        rotate([0,-90,0]){
                            #Screwcutter();
                        }
                    }
                }
                //TEST_CUTCYLINDER();
            }
            else{
                echo("CUT_MODULES_RENDERED= ",CUT_MODULES_RENDERED);
            }
        }
        union(){
            
        }
        translate([ 0,0,0]){
        }
    }
}
// ===============================================================================
// = Module to help coloring different modules to make it easier 
// ===============================================================================
module see_me_in_colourful(){ // iterates the given modules and colors them automaticly by setting values using trigonometric funktions
    translate([0,0,0]){
        for(i=[0:1:$children-1]){
            a=255;
            b=50;       // cuts away the dark colors to prevent bad visual contrast to backgound
            k_farbabstand=((a-b)/$children);
            Farbe=((k_farbabstand*i)/255);
            SINUS_Foo=0.5+(sin(((360/(a-b))*k_farbabstand)*(i+1)))/2;
            COSIN_Foo=0.5+(cos(((360/(a-b))*k_farbabstand)*(i+1)))/2;
            color(c = [ SINUS_Foo,
                        1-(SINUS_Foo/2+COSIN_Foo/2),
                        COSIN_Foo],
                        alpha = 0.5){  
                difference(){
                    render(convexity=10){children(i);} //renders the modules, effect is that inner holes become visible
                    //children(i);
                    translate([70/2,0,0]){
                        //cube([80,90,150],center=true);
                    }
// Creates a Cutting to see a Sidesection cut of the objects
                    color(c = [ SINUS_Foo,
                                1-(SINUS_Foo/2+COSIN_Foo/2),
                                COSIN_Foo],
                                alpha = 0.0){
                        translate([70/2,0,0]){
                            //cube([30,20,150],center=true);
                        }
                        translate([-50,-50,0]){
                            //cube([100,50,200],center=false);
                        }
                    }
                }
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- Enviroment Modules ------------------------=
// ===============================================================================
// Modules that resembles the Enviroment aka the helmet where to atach a camera mount



// ===============================================================================
// =--------------------------------- Modules -----------------------------------=
// ===============================================================================
//TEST_OBJECT();

module TEST_OBJECT(){
    difference(){
        TEST_CUTCUBE(TestSlab_X,TestSlab_Y,TestSlab_Z);
        TEST_CUTCYLINDER();
    }
    TEST_SPHERE();
}

module TEST_CUTCUBE(X=30,Y=60,Z=15){
    cube([X,Y,Z]);
}
module TEST_SPHERE(D=TestSphere_D){
//$fn = $preview ? 12 : 72; // Facets in preview (F5) set to 12, in Reder (F6) is set to 72
    difference(){
        sphere(d=D);
        TEST_CUTCYLINDER();
    }
}
module TEST_CUTCYLINDER(H=TestCylinder_H,D1=TestCylinder_D1,D2=TestCylinder_D2){
    cylinder(h=H,d1=D1,d2=D2,$fn=24);
}

// ===============================================================================
// ---------------------------------- Cutting Modules ----------------------------
// ===============================================================================
//Press_Fit_Cut(33,14,17,0.8);
module Press_Fit_Cut(Angle=22,Thickness=11,Length=22,Width=0.2){
    rotate([0,0,Angle]){
        translate([0,0,Thickness/2]){
            cylinder(h=Thickness,d=Width,center=true,$fn=12);
        }
        translate([0,-Width/2,0]){
            cube([Length,Width,Thickness]);
        }
        translate([Length,0,Thickness/2]){
            cylinder(h=Thickness,d=Width,center=true,$fn=12);
        }
    }
}

//Round_CUTTER(H,DIAMETER);
module Round_CUTTER(H,DIAMETER){
    difference(){
        cube([H,H,H]);
            rotate([-90,0,0]){
                cylinder(h=H,d=DIAMETER);
            }
        }        
        translate([DIAMETER/2,0,DIAMETER/2]){
            rotate([-90,0,0]){
                cylinder(h=H,d=DIAMETER,$fn=74);
        }
    }
}
//Screwcutter(100,10,100,4,1,5);
module Screwcutter( SCREW_HEAD_h=200,
                    SCREW_HEAD_d=10,
                    SCREW_BOLT_h=200,
                    SCREW_BOLT_d=4.5,
                    SCREW_CAMPFER_h,
                    SCREW_CAMPFER_d=5    ){
    translate([0,0,-SCREW_HEAD_h]){
        cylinder(h=SCREW_HEAD_h,d=SCREW_HEAD_d,$fn=32);
    }
    translate([0,0,0]){
        cylinder(h=SCREW_CAMPFER_h,d2=SCREW_BOLT_d,d1=SCREW_CAMPFER_d,$fn=32);    
    }
    translate([0,0,0]){
        cylinder(h=SCREW_BOLT_h,d=SCREW_BOLT_d,$fn=32);
    }
}
//Bolt(25,3,8,3);
module Bolt(BOLTLENGTH,BOLTDIAMETER,HEADDIAMETER,HEADHEIGHT){
    cylinder(h=BOLTLENGTH,d=BOLTDIAMETER,center=false,$fn=FN_Performance);
    translate([0,0,-HEADHEIGHT/2]){
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
    }
}
//Projection_Cutter(3){sphere(10);};
module Projection_Cutter(Offset_z){    
    projection(cut = true){
        translate([0,0,Offset_z]){
            children();
        }
    }
}
// ===============================================================================
// ---------------------------------- Intersection Modules -----------------------
// ===============================================================================

module Intersection_Test_Cut(PLAIN,THICKNESS,OFFSET){
// ==== EXAMPLE ====
//    !Intersection_Test_Cut("xy",1,7/2){sphere(7);};
// ==== EXAMPLE ====
    if (PLAIN=="xz"){
        intersection(){
            children();
            translate([0,OFFSET,0]){
                cube([100,THICKNESS,100],center=true);
            }
        }
    }
    else if (PLAIN=="xy") {
        intersection(){
            children();
            translate([0,0,OFFSET]){
                cube([500,500,THICKNESS],center=true);
            }
        }
    }
    else if (PLAIN=="yz") {
        intersection(){
            children();
            translate([OFFSET,0,0]){
                cube([THICKNESS,100,100],center=true);
            }
        }   
    }
}
// ===============================================================================
// ---------------------------------- Linear Extrude Modules ---------------------
// ===============================================================================
//LinExtr_Base_Shape_Poligon();
module LinExtr_Base_Shape_Poligon(){
    linear_extrude(Thicknes*2){
        Base_Shape_Poligon();
    }
}
//Ring_Shaper(3,15,1.5);
module Ring_Shaper(HEIGHT,OUTER,WALLTHICKNESS){
    linear_extrude(HEIGHT){
        2D_Ring_Shape(OUTER,WALLTHICKNESS);
    }
}
//Linear_Extruding(10,-1){2D_Rounded_Square_Base_Shape(10,20,3);}
module Linear_Extruding(ExtrudeLength,ExrtudingDirektionInverter){
//   0  Normal
//  -1  inverted
//   1  
    Length=ExtrudeLength;
    translate([0,0,Length*ExrtudingDirektionInverter]){
        linear_extrude(height=ExtrudeLength){
            children();
        }
    }
}

// ===============================================================================
// ---------------------------------- Rotate Extrude Modules ---------------------
// ===============================================================================

//DONUT(1,20,1,7);
module DONUT(DIAMETER,DIAMETER_RING,SCAL_X,SCAL_Y){
//DIAMETER The dough part
//DIAMETER_RING The hole part
//SCAL_X, skales the x dimension
//SCAL_Y, skales the y dimension
    rotate_extrude(angle=360,convexity=3,$fn=FN_Fine){
        translate([DIAMETER_RING,0,0]){
            scale([SCAL_X,SCAL_Y,1]){
                circle(d=DIAMETER,$fn=FN_Fine);
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- 2D-Shapes ---------------------------------=
// ===============================================================================
// Base_Shape_Poligon();
module Base_Shape_Poligon(){
    difference(){
        hull(){
            square([WidthBaseSchape,HeightBaseSchape]);
            square([Thicknes,HeightBaseSchape+Thicknes]);
            translate([OutstandRest_Width,OutstandRest_Height,0]){
                #circle(d=Circle_D);
            }
            translate([OutStand,OutStand_UpRise,0]){
                circle(d=Circle_D);
            }
            translate([WidthBaseSchape,Circle_D/2,0]){
                circle(d=Circle_D);
            }
        }
        translate([Thicknes,Thicknes]){
            Base_Shape_Poligon_Cut();
        }
        translate([OutstandRest_Width,OutstandRest_Height-Circle_D/4,0]){
                circle(d=Pipe_D);
                projection(cut=true){Press_Fit_Cut(218,14,10,0.8);}
            }
        translate([OutStand-Circle_D/2,OutStand_UpRise+Circle_D/8,0]){
            circle(d=Pipe_D);
            projection(cut=true){Press_Fit_Cut(202,1,10,0.8);}
        }
    }
}

//Base_Shape_Poligon_Cut();
module Base_Shape_Poligon_Cut(){
ROUNDER=5;
X_SCALE=((OutStand)-2*Thicknes)/(OutStand);
Y_SCALE=(OutstandRest_Height-2*Thicknes)/OutstandRest_Height;
    Smooth(r=ROUNDER){
        scale([X_SCALE,Y_SCALE]){
            hull(){
                square([WidthBaseSchape,HeightBaseSchape]);
                square([Thicknes,HeightBaseSchape+Thicknes]);
                translate([OutstandRest_Width,OutstandRest_Height+ROUNDER,0]){
                    #circle(d=1);
                }
                translate([OutStand,OutStand_UpRise,0]){
                    circle(d=1);
                }
                translate([WidthBaseSchape,Circle_D/2,0]){
                    circle(d=1);
                }
            }
        }
    }
}
//2D_Ring_Shape(202,1);
module 2D_Ring_Shape(OUTER_D,WALLTHICKNESS){
    difference(){
        circle(d=OUTER_D,$fn=FN_Fine);
        circle(d=OUTER_D-2*WALLTHICKNESS,$fn=FN_Fine);
    }
}
//2D_Rounded_Square_Base_Shape(10,20,3);
module 2D_Rounded_Square_Base_Shape(DIMENSION_X=10,DIMENSION_Y=20,RADIUS=2,CENTER=true){
    if(CENTER){
        translate([0,0,0]){
            minkowski(){
                square([DIMENSION_X-RADIUS*2,DIMENSION_Y-RADIUS*2],center=CENTER);
                circle(r=RADIUS,$fn=FN_Fine);
            }
        }
    }
    else{
        translate([RADIUS,RADIUS,0]){
            minkowski(){
                square([DIMENSION_X-RADIUS*2,DIMENSION_Y-RADIUS*2],center=CENTER);
                circle(r=RADIUS,$fn=FN_Fine);
            }
        }
    }
}
//HEX_Mesh_Pattern(){ Mesh(2.5,2.5);}
module HEX_Mesh_Pattern(X=10,Y=30,DELTA=5,GRPL_X=45,GRPL_Y=115){
Count_X=X;
Count_Y=Y;
DIMENSION_X=35;
DIMENSION_Y=67;


//DELTA=1;

X_STEPP=5.5+DELTA;
Y_STEPP=7.5+DELTA;

k=DELTA; //Distance between Hexshapes may be HEX_D/4 is good
HEX_D=(DIMENSION_X-((Count_X-1)*k/2))/(Count_X-1);

SCALE_Y=DIMENSION_Y/((HEX_D/2+k/4)*sqrt(3)*(Count_Y-1));
echo("HEX_D*Count_Y",HEX_D*(Count_Y));
echo("GrindingPlate_Y",DIMENSION_Y);
echo("SCALE_Y",SCALE_Y);

//square([15,(HEX_D/2+k/4)*sqrt(3)*(Count_Y-1)]); // Helper Foo
    
// +++++++++++++++++++++++++++++++++++++++++
    scale([1,SCALE_Y,1]){
        union(){
            for(j=[0:1:Count_Y-1]){
                for(i=[0:1:Count_X-1-j%2]){
                    translate([i*(HEX_D+k/2),0,0]){
                        translate([(HEX_D/2+k/4)*(j%2),
                                    j*((HEX_D/2+k/4)*sqrt(3)),
                                    0]                          ){
                        //translate([0,j*Y_STEPP,0]){
                        rotate([0,0,60]){
                            //Mesh(0.5){square([HEX_D,HEX_D*1.2],center=true);}
                            circle(d=HEX_D,$fn=6);
                        }
                            //children();
                        }
                    }
                }
            }
        }
    }
}
//Mesh(4){square([7,10],center=true);}
module Mesh(RADIUS=0.0){
minkowski(){
    children();
    circle(r=RADIUS,$fn=144);
    }
}
// ===============================================================================
// =--------------------------------- Symetrie Helper ---------------------------=
// ===============================================================================
//XY_Symetrie(10,25){cube(10);}
module XY_Symetrie(X=10,Y=25){
   translate([X,Y,0]){
       children();
       }
    mirror([1,0,0]){
        translate([X,Y,0]){
            children();
       }
    }
    mirror([0,1,0]){
        translate([X,Y,0]){
            children();
        }
        mirror([1,0,0]){
            translate([X,Y,0]){
                children();
            }
        }
    }
}
//MirrorMirrorOnTheWall(27,65){cube(10);}
module MirrorMirrorOnTheWall(Offset_X,Offset_Y){
    translate([-Offset_X,Offset_Y,0]){
        children();
        mirror([0,1,0]){
            children();
        }
    }
    translate([Offset_X,-Offset_Y,0]){
        mirror([1,0,0]){
            children();
            mirror([1,0,0]){
                children();
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- Textembossing -----------------------------=
// ===============================================================================

// ===============================================================================
// =--------------------------------- Smoothing ---------------------------------=
// ===============================================================================
2D_Smooth_r=1;
// Radius of a outer Tip Rounding 
2D_Fillet_r=1;
// Radius of a inner corner Ronding
2D_Chamfer_DELTA_INN=1;
2D_Chamfer_DELTA_OUT=2;
// a straigt line on edges and corners
2D_Chamfer_BOOLEAN=false;    
module Smooth(r=3){
    //$fn=30;
    offset(r=r,$fn=30){
        offset(r=-r,$fn=30){
        children();
        }
    }
}
module Fillet(r=3){
    //$fn=30;
    offset(r=-r,$fn=30){
        offset(r=r,$fn=30){
            children();
        }
    }
}
module Chamfer_OUTWARD(DELTA_OUT=3){
    //$fn=30;
    offset(delta=DELTA_OUT,chamfer=true,$fn=30){
        offset(delta=-DELTA_OUT,chamfer=true, $fn=30){
            children();
        }
    }
}
module Chamfer_INWARD(DELTA_INN=3){
    //$fn=30;
    offset(delta=-DELTA_INN,chamfer=true,$fn=30){
        offset(delta=DELTA_INN,chamfer=true, $fn=30){
            children();
        }
    }
}
// ===============================================================================
// =--------------------------------- Ruthex --------------------------------=
// ===============================================================================
// Dimensions for Ruthex Tread inseerts
//RUTHEX_M3();
module RUTHEX_M3(){    
L=5.7+5.7*0.25; // Length + Margin
echo("RUTHEX",L);
D1=4.0;    
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=L,d1=D1,d2=D1,$fn=FN_Performance);
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- Import STL --------------------------------=
// ===============================================================================
module NAME_OF_IMPORT(){
    rotate([0,0,-90]){
        translate([-515,-100,-45]){
            import("PATH/TO/FILE.stl",convexity=3);
        }
    }
}
// ===============================================================================
// =--------------------------------- Import PNG --------------------------------=
// ===============================================================================
module NAME_OF_IMPORT(){
    rotate([0,0,-90]){
        translate([-515,-100,-45]){
            import("PATH/TO/FILE.PNG",convexity=3);
        }
    }
}