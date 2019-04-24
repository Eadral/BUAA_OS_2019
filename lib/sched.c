#include <env.h>
#include <pmap.h>
#include <printf.h>

/* Overview:
 *  Implement simple round-robin scheduling.
 *  Search through 'envs' for a runnable environment ,
 *  in circular fashion statrting after the previously running env,
 *  and switch to the first such environment found.
 *
 * Hints:
 *  The variable which is for counting should be defined as 'static'.
 */

static u_long count = 0;
int c_list = 0;
struct Env* e = NULL;

void sched_yield(void) {
    if (count == 0) {
        e = LIST_FIRST(&env_sched_list[c_list]);
        do {
            if (e == NULL) {
                panic("no runnable process\n");   
            }
            count = e->env_pri;
            LIST_REMOVE(e, env_sched_link);
            LIST_INSERT_HEAD(&env_sched_list[1 - c_list], e, env_sched_link);
            if (LIST_EMPTY(&env_sched_list[c_list])) {
                c_list = 1 - c_list;
            }
        } while (e->env_status != ENV_RUNNABLE);
    }
    count--;
    //printf("\n@%d@  ", env->env_pri);
    env_run(e);
}
