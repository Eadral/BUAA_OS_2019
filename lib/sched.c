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

u_long count = 0;
int c_list = 0;
struct Env* env = NULL;

void sched_yield(void) {
    if (count == 0) {
        env = LIST_FIRST(&env_sched_list[c_list]);
        if (env == NULL) {
            panic("no runnable process\n");   
        }
        count = env->env_pri;
        LIST_REMOVE(env, env_sched_link);
        LIST_INSERT_HEAD(&env_sched_list[1 - c_list], env, env_sched_link);
        if (LIST_EMPTY(&env_sched_list[c_list])) {
            c_list = 1 - c_list;
        }
    }
    count--;
    //printf("\n@%d@  ", env->env_pri);
    env_run(env);
}
