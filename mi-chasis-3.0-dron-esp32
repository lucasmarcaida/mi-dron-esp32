// ====================================================================
// CHASIS MICRO DRON ESP32-S3 (Motores Coreless 8520 + MOSFETs AO3400A)
// Diseñado para: ESP32-S3 Super Mini, MPU-6050, VL53L0X y LiPo 1S
// ====================================================================

$fn = 40; // Resolución de curvas

// --------------------------------------------------------------------
// Parámetros Principales (en mm)
// --------------------------------------------------------------------
motor_dia      = 8.6;   // Diámetro interno (8.5mm motor + 0.1mm tolerancia)
motor_height   = 16.0;  // Altura del soporte del motor
arm_length     = 42.0;  // Distancia del centro al motor (soporta hélices de 40-55mm)
center_width   = 28.0;  // Ancho bahía central (ESP32-S3 Super Mini)
center_length  = 36.0;  // Largo bahía central
batt_width     = 18.5;  // Ancho batería LiPo 1S (380-500 mAh)
batt_height    = 8.5;   // Alto batería LiPo 1S
wall_thickness = 1.2;   // Grosor de pared estructural

// --------------------------------------------------------------------
// Módulo: Soporte de Motor Coreless 8520
// --------------------------------------------------------------------
module motor_holder() {
    difference() {
        // Cilindro exterior
        cylinder(r = (motor_dia/2) + wall_thickness, h = motor_height, center = false);
        
        // Hueco interno para encajar el motor a presión
        translate([0, 0, -1])
            cylinder(r = motor_dia/2, h = motor_height + 2, center = false);
            
        // Ranura vertical para paso de cables y alivio de tensión
        translate([-1.0, -((motor_dia/2) + wall_thickness + 1), -1])
            cube([2.0, (motor_dia/2) + wall_thickness + 2, motor_height + 2]);
    }
}

// --------------------------------------------------------------------
// Módulo: Bahía Central + Guía de Batería
// --------------------------------------------------------------------
module center_plate() {
    difference() {
        // Placa base superior
        cube([center_width, center_length, 1.6], center = true);
        
        // Ventana central para el sensor de altura ToF (VL53L0X / GY-53)
        cube([14, 14, 4], center = true);
        
        // Perforaciones de alivio de peso
        translate([8, 11, 0])  cylinder(r = 3.2, h = 4, center = true);
        translate([-8, 11, 0]) cylinder(r = 3.2, h = 4, center = true);
        translate([8, -11, 0]) cylinder(r = 3.2, h = 4, center = true);
        translate([-8, -11, 0]) cylinder(r = 3.2, h = 4, center = true);
    }
    
    // Cuna/Soporte inferior para la batería LiPo 1S
    translate([0, 0, -(batt_height/2 + 0.8)]) {
        difference() {
            cube([batt_width + 2.0, center_length * 0.65, batt_height], center = true);
            cube([batt_width, center_length, batt_height + 1], center = true);
        }
    }
}

// --------------------------------------------------------------------
// Ensamblaje Completo del Chasis
// --------------------------------------------------------------------
union() {
    // Bahía central con soporte de batería y sensor
    center_plate();

    // Brazos estructurales en X y soportes de motor
    for (angle = [45, 135, 225, 315]) {
        rotate([0, 0, angle]) {
            // Brazo con perfil reforzado liviano
            translate([0, -1.2, -0.8])
                cube([arm_length, 2.4, 2.0]);
            
            // Montaje de motor al extremo del brazo
            translate([arm_length, 0, -2.0]) {
                motor_holder();
            }
        }
    }
}
