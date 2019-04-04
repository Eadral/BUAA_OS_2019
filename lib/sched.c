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
struct Env* env = NULL;

void sched_yield(void) {
    
    if (count != 0) {
        count--;
    } else {
        env = LIST_FIRST(&env_sched_list[0]);
        if (env == NULL)
            panic("NO runnable process\n");
        count = env->env_pri;
        LIST_REMOVE(env, env_sched_link);
        LIST_INSERT_TAIL(&env_sched_list[0], env, env_sched_link);
    }
    env_run(env);
    return;
}
