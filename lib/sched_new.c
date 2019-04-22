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

u_long cnt = 0;
int cl = 0;
struct Env* e = NULL;

void sched_yield_new(void) {
    if (cnt == 0) {
        if (e != NULL) {
            e->env_pri--;
            if (e->env_pri == 0) {
                env_destroy(e);
            }
        }
        e = LIST_FIRST(&env_sched_list[cl]);
        do {
            if (e == NULL) {
                panic("no runnable process\n");   
                continue;
            }
            cnt = e->env_pri;
            LIST_REMOVE(e, env_sched_link);
            LIST_INSERT_HEAD(&env_sched_list[1 - cl], e, env_sched_link);
            if (LIST_EMPTY(&env_sched_list[cl])) {
                cl = 1 - cl;
            }
        } while (e->env_status != ENV_RUNNABLE);
    }
    cnt--;
    //printf("\n@%d@  ", env->env_pri);
    env_run(e);
}
