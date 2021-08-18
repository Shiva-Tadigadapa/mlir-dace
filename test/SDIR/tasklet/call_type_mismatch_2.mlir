// XFAIL: *
// RUN: sdir-opt %s | sdir-opt | FileCheck %s

// CHECK: module
// CHECK: sdir.sdfg
sdir.sdfg{entry=@state_0} @sdfg_0 {
    // CHECK: sdir.state @state_0
    sdir.state @state_0{
        // CHECK: sdir.tasklet 
        // CHECK-SAME: @add
        // CHECK-SAME: [[NAMEA:%[a-zA-Z0-9_]*]]
        // CHECK-SAME: [[NAMEB:%[a-zA-Z0-9_]*]]
        sdir.tasklet @add(%a: i32, %b: i32) -> i32{
            // CHECK-NEXT: [[NAMEC:%[a-zA-Z0-9_]*]]
            // CHECK-SAME: [[NAMEA]] 
            // CHECK-SAME: [[NAMEB]]
            %c = addi %a, %b : i32
            // CHECK-NEXT: sdir.return [[NAMEC]]
            sdir.return %c : i32
        }
        // CHECK: [[NAME1:%[a-zA-Z0-9_]*]] = constant
        // CHECK-SAME: i64
        %1 = constant 1 : i64
        // CHECK-NEXT: {{%[a-zA-Z0-9_]*}} = sdir.call @add
        // CHECK-SAME: ([[NAME1]], [[NAME1]])
        // CHECK-SAME: (i64, i64) -> i32
        %c = sdir.call @add(%1, %1) : (i64, i64) -> i32
    }
}