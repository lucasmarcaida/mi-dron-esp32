// ====================================================================
// CHASIS MICRO DRON ESP32-S3 - CORREGIDO
// Motores Coreless 8520 + LiPo 1S 280 mAh (501540)
// ====================================================================

$fn = 40; 

// Parámetros Principales (en mm)
motor_dia      = 8.6;   // 8.5mm motor + 0.1mm tolerancia
motor_height   = 16.0;  // Altura del soporte del motor
arm_length     = 43.0;  // Distancia del centro al motor (margen ampliado para hélices 55mm)
center_width   = 28.0;  // Bahía central ESP32-S3 Super Mini
center_length  = 36.0;  
batt_width     = 15.4;  // Ancho real LiPo 280 mAh (501540)
batt_height    = 5.4;   // Alto real LiPo 280 mAh (501540)
wall_thickness = 1.2;   

module motor_holder() {
    difference() {
        cylinder(r = (motor_dia/2) + wall_thickness, h = motor_height, center = false);
        translate([0, 0, -1])
            cylinder(r = motor_dia/2, h = motor_height + 2, center = false);
        translate([-1.0, -((motor_dia/2) + wall_thickness + 1), -1])
            cube([2.0, (motor_dia/2) + wall_thickness + 2, motor_height + 2]);
    }
}

module center_plate() {
    difference() {
        cube([center_width, center_length, 1.6], center = true);
        cube([14, 14, 4], center = true); // Ventana VL53L0X
        
        // Alivio de peso
        translate([8, 11, 0])   cylinder(r = 3.2, h = 4, center = true);
        translate([-8, 11, 0])  cylinder(r = 3.2, h = 4, center = true);
        translate([8, -11, 0])  cylinder(r = 3.2, h = 4, center = true);
        translate([-8, -11, 0]) cylinder(r = 3.2, h = 4, center = true);
    }
    
    // Cuna inferior ajustada a la batería 280 mAh
    translate([0, 0, -(batt_height/2 + 0.8)]) {
        difference() {
            cube([batt_width + 2.0, center_length * 0.65, batt_height], center = true);
            cube([batt_width, center_length, batt_height + 1], center = true);
        }
    }
}

union() {
    center_plate();

    for (angle = [45, 135, 225, 315]) {
        rotate([0, 0, angle]) {
            // Brazo reforzado verticalmente (3.8 mm de espesor para evitar flexión)
            translate([0, -1.25, -1.9])
                cube([arm_length, 2.5, 3.8]);
            
            translate([arm_length, 0, -2.0]) {
                motor_holder();
            }
        }
    }
}
