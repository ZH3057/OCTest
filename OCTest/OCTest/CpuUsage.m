//
//  CpuUsage.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "CpuUsage.h"

#import <mach/thread_info.h>
#import <mach/mach_types.h>
#import <mach/mach_init.h>
#import <mach/task.h>
#import <mach/thread_act.h>
#import <mach/vm_map.h>

@implementation CpuUsage

+ (integer_t)cpuUseage {
    //thread_act_array_t => *thread_act_array_t
    //thread_act_array_t => thread_act_port_array_t
    // int 组成的数组 thread[1] = 5635
    thread_act_array_t threads;
    
    // mach_msg_type_number_t => natural_t
    // natural_t => __darwin_natural_t
    // __darwin_natural_t => unsigned int
    mach_msg_type_number_t threadCount = 0;
    
    const task_t thisTask = mach_task_self();
    
    /*
     kern_return_t task_threads
     (
        task_inspect_t target_task,
        thread_act_array_t *act_list,
        mach_msg_type_number_t *act_listCnt
     );
     */
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    integer_t cpuUsage = 0;
    for (int i = 0; i < threadCount; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        
        
        /**
         kern_return_t thread_info
         (
            thread_inspect_t target_act,
            thread_flavor_t flavor,
            thread_info_t thread_info_out,
            mach_msg_type_number_t *thread_info_outCnt
         );
         */
        kern_return_t result = thread_info(
                                           (thread_inspect_t)threads[i],
                                           THREAD_BASIC_INFO,
                                           (thread_info_t)threadInfo,
                                           &threadInfoCount
                                           );
        if (result == KERN_SUCCESS) {
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                cpuUsage += threadBaseInfo->cpu_usage;
            }
        }
    }
    
    
    /**
     kern_return_t vm_deallocate
     (
        vm_map_t target_task,
        vm_address_t address,
        vm_size_t size
     );
     */
    kern_return_t vm_res = vm_deallocate(
                                           mach_task_self(),
                                           (vm_address_t)threads,
                                           threadCount * sizeof(thread_t)
                                         );
    
    assert(vm_res == KERN_SUCCESS);
    
    return cpuUsage;
}

@end
