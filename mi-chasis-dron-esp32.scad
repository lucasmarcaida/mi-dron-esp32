// ======================================================
// CHASIS MICRO DRON ESP32-S3 (Motores 7mm x 20mm)
// ======================================================

$fn = 40; // Resolución de curvas

// Parametros (en mm)
motor_dia = 7.0;       // Diámetro del motor coreless (7mm)
motor_height = 20.0;   // Largo del motor
arm_length = 42.0;     // Distancia del centro a los motores
duct_inner_dia = 42.0; // Espacio para helices de 40mm
duct_wall = 1.2;       // Grosor protector
center_width = 28.0;   // Ancho bahía ESP32 / MPU6050
center_length = 38.0;  // Largo bahía
batt_width = 20.0;     // Ancho batería LiPo 600mAh
batt_height = 8.5;     // Alto batería LiPo

module motor_holder() {
    difference() {
        cylinder(r = (motor_dia/2) + 1.2, h = motor_height * 0.75, center = false);
        // Hueco motor
        translate([0, 0, -1])
            cylinder(r = motor_dia/2, h = motor_height + 2, center = false);
        // Ranura para cables
        translate([-0.8, -((motor_dia/2)+2), -1])
            cube([1.6, (motor_dia/2)+2, motor_height + 2]);
    }
}

module prop_duct() {
    difference() {
        cylinder(r = (duct_inner_dia/2) + duct_wall, h = 10, center = false);
        translate([0, 0, -1])
            cylinder(r = duct_inner_dia/2, h = 12, center = false);
    }
}

module center_plate() {
    difference() {
        // Platillo principal
        cube([center_width, center_length, 2], center = true);
        // Ventana central inferior para el sensor ToF VL53L0X
        cube([14, 14, 5], center = true);
    }
    // Soportes/Guías laterales para batería LiPo (debajo del chasis)
    translate([0, 0, - (batt_height/2 + 1)]) {
        difference() {
            cube([batt_width + 2.4, center_length * 0.7, batt_height], center = true);
            cube([batt_width, center_length + 2, batt_height + 1], center = true);
        }
    }
}

// Renderizado del Chasis completo
union() {
    // Bahía central
    center_plate();

    // Brazos y soportes de motores en X
    for (angle = [45, 135, 225, 315]) {
        rotate([0, 0, angle]) {
            // Brazo de conexión
            translate([0, 0, 0])
                cube([arm_length, 2.5, 2]);
            
            // Montaje de motor y protector
            translate([arm_length, 0, -2]) {
                motor_holder();
                prop_duct();
            }
        }
    }
}
