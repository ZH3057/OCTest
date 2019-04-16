//
//  MemoryUsage.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "MemoryUsage.h"
#import <mach/task_info.h>
#import <mach/task.h>
#import <mach/mach_init.h>

@implementation MemoryUsage

+ (uint64_t)memoryUsage {
    /**
     struct task_vm_info {
        mach_vm_size_t  virtual_size;
        integer_t       region_count;
        integer_t       page_size;
        mach_vm_size_t  resident_size;
        mach_vm_size_t  resident_size_peak;
     
        mach_vm_size_t  device;
        mach_vm_size_t  device_peak;
        mach_vm_size_t  internal;
        mach_vm_size_t  internal_peak;
        mach_vm_size_t  external;
        mach_vm_size_t  external_peak;
        mach_vm_size_t  reusable;
        mach_vm_size_t  reusable_peak;
        mach_vm_size_t  purgeable_volatile_pmap;
        mach_vm_size_t  purgeable_volatile_resident;
        mach_vm_size_t  purgeable_volatile_virtual;
        mach_vm_size_t  compressed;
        mach_vm_size_t  compressed_peak;
        mach_vm_size_t  compressed_lifetime;
     
     
        mach_vm_size_t  phys_footprint;
     
        mach_vm_address_t       min_address;
        mach_vm_address_t       max_address;
     };
     
     */
    // struct task_vm_info
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    
    
    /**
     kern_return_t task_info
     (
         task_name_t target_task,
         task_flavor_t flavor,
         task_info_t task_info_out,
         mach_msg_type_number_t *task_info_outCnt
     );
     */
    kern_return_t result = task_info(
                                     mach_task_self(),
                                     TASK_VM_INFO,
                                     (task_info_t)&vmInfo,
                                     &count);
    
    if (result == KERN_SUCCESS) {
        return vmInfo.phys_footprint;
    }
    
    return 0;
}

@end
