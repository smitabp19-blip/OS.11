1. Write the program to simulate Non-preemptive Shortest Job First (SJF) scheduling.
the arrival time and first CPU burst for different n number of processes should be input to the algorithm.
The next CPU burst should be generated randomly. The output should give Gantt chart, turnaround time and waiting time for each process.
Also find the average waiting time and turnaround time.



#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main()
{
    int n, i, j, time = 0, min;
    int at[20], bt[20], ct[20], wt[20], tat[20], done[20] = {0};
    float awt = 0, atat = 0;
    printf("Enter number of processes: ");
    scanf("%d", &n);
    for(i = 0; i < n; i++)
    {
        printf("P%d Arrival Time: ", i+1);
        scanf("%d", &at[i]);
        printf("P%d First CPU Burst: ", i+1);
        scanf("%d", &bt[i]);
        bt[i] += rand() % 5 + 1;
    }
    printf("\nGantt Chart:\n");
    for(i = 0; i < n; i++)
    {
        min = -1;
        for(j = 0; j < n; j++)
            if(!done[j] && at[j] <= time &&
              (min == -1 || bt[j] < bt[min]))
                min = j;
        if(min == -1)
        {
            time++;
            i--;
            continue;
        }
        printf("| P%d ", min + 1);
        time += bt[min];
        ct[min] = time;
        tat[min] = ct[min] - at[min];
        wt[min] = tat[min] - bt[min];
        done[min] = 1;
        awt += wt[min];
        atat += tat[min];
    }
    printf("|\n\n");
    printf("Process\tAT\tBT\tWT\tTAT\n");
    for(i = 0; i < n; i++)
        printf("P%d\t%d\t%d\t%d\t%d\n",
               i+1, at[i], bt[i], wt[i], tat[i]);
    printf("\nAverage Waiting Time = %.2f", awt/n);
    printf("\nAverage Turnaround Time = %.2f\n", atat/n);
    return 0;
}




2. Write the program to simulate Round Robin (RR) scheduling. 
The arrival time and first CPU burst for different n number of processes should be input to the algorithm.
Also give the time quantum as input. The next CPU burst should be generated randomly. 
The output should give Gantt chart, turnaround time and waiting time for each process. Also find the average waiting time and turnaround time.


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
    int n, tq, i, time = 0, done = 0;
    int at[10], bt[10], rem[10], ct[10], wt[10], tat[10];
    srand(time(0));
    printf("Enter number of processes: ");
    scanf("%d", &n);
    for(i = 0; i < n; i++) {
        printf("P%d Arrival Time: ", i + 1);
        scanf("%d", &at[i]);
        printf("P%d First CPU Burst: ", i + 1);
        scanf("%d", &bt[i]);
        rem[i] = bt[i];
    }
    printf("Enter Time Quantum: ");
    scanf("%d", &tq);
    printf("\nGantt Chart:\n");
    while(done < n) {
        for(i = 0; i < n; i++) {
            if(at[i] <= time && rem[i] > 0) {
                printf("| P%d ", i + 1);
                if(rem[i] > tq) {
                    time += tq;
                    rem[i] -= tq;
                    rem[i] += rand() % 5 + 1;
                }
                else {
                    time += rem[i];
                    rem[i] = 0;
                    ct[i] = time;
                    done++;
                }
            }
        }
        if(done < n)
            time++;
    }
    printf("|\n");
    printf("\nProcess\tAT\tCT\tTAT\tWT\n");
    float awt = 0, atat = 0;
    for(i = 0; i < n; i++) {
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        printf("P%d\t%d\t%d\t%d\t%d\n",
               i + 1, at[i], ct[i], tat[i], wt[i]);
        awt += wt[i];
        atat += tat[i];
    }
    printf("\nAverage Waiting Time = %.2f", awt / n);
    printf("\nAverage Turnaround Time = %.2f\n", atat / n);
    return 0;
}






3. Write the program to simulate FCFS CPU scheduling. 
The arrival time and first CPU- burst for different n number of processes should be input to the algorithm. 
The next CPU-burst should be generated randomly. The output should give Gantt chart, turnaround time and waiting time for each process.
Also find the average waiting time and turnaround time.


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
struct Process {
    int pid;
    int arrival;
    int burst1;
    int burst2;
    int completion;
    int turnaround;
    int waiting;
};
int main() {
    int n, i;
    int current_time = 0;
    float avg_waiting = 0, avg_turnaround = 0;
    printf("Enter number of processes: ");
    scanf("%d", &n);
    struct Process p[n];
    for (i = 0; i < n; i++) {
        p[i].pid = i + 1;
        printf("\nEnter Arrival Time for P%d: ", i + 1);
        scanf("%d", &p[i].arrival);
        printf("Enter First CPU Burst for P%d: ", i + 1);
        scanf("%d", &p[i].burst1);
    }
    srand(time(0));
    for (i = 0; i < n; i++) {
        p[i].burst2 = rand() % 10 + 1;
    }
    printf("\n\nGANTT CHART\n");
    printf("---------------------------------------------\n");
    for (i = 0; i < n; i++) {
        if (current_time < p[i].arrival) {
            current_time = p[i].arrival;
        }
        printf("| P%d ", p[i].pid);
        current_time += p[i].burst1;
        current_time += p[i].burst2;
        p[i].completion = current_time;
        p[i].turnaround = p[i].completion - p[i].arrival;
        p[i].waiting = p[i].turnaround -
                       (p[i].burst1 + p[i].burst2);
        avg_waiting += p[i].waiting;
        avg_turnaround += p[i].turnaround;
    }
    printf("|\n");
    printf("---------------------------------------------\n");
    printf("\nProcess\tAT\tBurst1\tBurst2\tCT\tTAT\tWT\n");
    for (i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
               p[i].pid,
               p[i].arrival,
               p[i].burst1,
               p[i].burst2,
               p[i].completion,
               p[i].turnaround,
               p[i].waiting);
    }
    avg_waiting = avg_waiting / n;
    avg_turnaround = avg_turnaround / n;
    printf("\nAverage Waiting Time = %.2f", avg_waiting);
    printf("\nAverage Turnaround Time = %.2f\n", avg_turnaround);
    return 0;
}







4. Write the program to simulate Preemptive Priority scheduling. 
The arrival time and first CPU-burst and priority for different n number of processes should be input to the algorithm. 
The next CPU-burst should be generated randomly. The output should give Gantt chart, turnaround time and waiting time for each process.
Also find the average waiting time and turnaround time .


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
    int n, i, t = 0, done = 0;
    int at[20], bt[20], rem[20], pr[20], ct[20], tat[20], wt[20];
    float awt = 0, atat = 0;
    srand(time(0));
    printf("Enter number of processes: ");
    scanf("%d", &n);
    for(i = 0; i < n; i++) {
        printf("P%d Arrival Time, Burst Time, Priority: ", i+1);
        scanf("%d%d%d", &at[i], &bt[i], &pr[i]);
        rem[i] = bt[i];
    }
    printf("\nGantt Chart:\n");
    while(done < n) {
        int p = -1;
        for(i = 0; i < n; i++)
            if(at[i] <= t && rem[i] > 0 &&
              (p == -1 || pr[i] < pr[p]))
                p = i;
        if(p == -1) {
            t++;
            continue;
        }
        printf("| P%d ", p+1);
        rem[p]--;
        t++;
        if(rem[p] == 0) {
            ct[p] = t;
            done++;
        }
    }
    printf("|\n\nProcess\tTAT\tWT\n");
    for(i = 0; i < n; i++) {
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        printf("P%d\t%d\t%d\n", i+1, tat[i], wt[i]);
        awt += wt[i];
        atat += tat[i];
    }
    printf("\nAverage Waiting Time = %.2f", awt/n);
    printf("\nAverage Turnaround Time = %.2f\n", atat/n);
    return 0;
}





5. Write the program to simulate Preemptive Shortest Job First (SJF) scheduling.
The arrival time and first CPU burst for different n number of processes should be input to the algorithm.
The next CPU burst should be generated randomly. The output should give Gantt chart, turnaround time and waiting time for each process.
Also find the average waiting time and turnaround time


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
    int n, i, t = 0, done = 0;
    int at[20], bt[20], rt[20], ct[20], wt[20], tat[20];
    printf("Enter number of processes: ");
    scanf("%d", &n);
    for(i = 0; i < n; i++) {
        printf("Arrival time and first burst of P%d: ", i + 1);
        scanf("%d%d", &at[i], &bt[i]);
        rt[i] = bt[i];
    }
    srand(time(0));
    printf("\nGantt Chart:\n");
    while(done < n) {
        int p = -1, min = 9999;
        for(i = 0; i < n; i++)
            if(at[i] <= t && rt[i] > 0 && rt[i] < min)
                min = rt[i], p = i;
        if(p == -1) {
            t++;
            continue;
        }
        printf("| P%d ", p + 1);
        rt[p]--;
        t++;
        if(rt[p] == 0) {
            ct[p] = t;
            done++;
        }
    }
    printf("|\n");
    for(i = 0; i < n; i++) {
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        printf("P%d next CPU burst = %d\n", i + 1, rand() % 10 + 1);
    }
    float aw = 0, atat = 0;
    printf("\nProcess\tAT\tBT\tCT\tTAT\tWT\n");
    for(i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\n",
               i + 1, at[i], bt[i], ct[i], tat[i], wt[i]);
        aw += wt[i];
        atat += tat[i];
    }
    printf("\nAverage Waiting Time = %.2f", aw / n);
    printf("\nAverage Turnaround Time = %.2f\n", atat / n);
    return 0;
}