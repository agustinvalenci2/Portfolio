#include <stdio.h>
#include <stdlib.h>
#include <math.h>
struct Process{
	int id;
	int arrival;
	int CPUtime;
	int remaining;
	int priority;
	int active;
	
};
int binomial(int n, double mean,double dv){
	int ans=0;
	double p=mean/n;
	for(int i = 0;i<n;i++){
		if ((double)rand() / RAND_MAX < p){
			ans+=1;
		}
	}
	 return ans;
}
typedef struct Process Process;
void swap(Process* a,Process* b){

	Process* p=a;

	a=b;

	b=p;
}
void FIFO(int n,Process* pr,int verbose){
	int time=0;
	int deadTime=0;
	int inactiveTime=0;

	for(int i =0;i<n;i++){
		for(int j=i+1;j<n;j++){
			if(pr[i].arrival<pr[j].arrival){
				
				swap(&pr[i],&pr[j]);

			}
		}
	}

	for(int i=0;i<n;i++){
		if(time<pr[i].arrival){
			inactiveTime+=pr[i].arrival-time;
			time=pr[i].arrival;
		}
		else{
			deadTime+=(time-pr[i].arrival);
		}
		if(verbose)
			printf("process id %d executing instant %d\n",pr[i].id,time);
		time+=pr[i].CPUtime;
		deadTime+=(time-pr[i].arrival);

	}
	printf("%d, %d\n",time,deadTime/n);
}
int countActives(Process* pr,int n){
	int count=0;
	for(int i =0;i<n;i++){
		count+=pr[i].active;
	}
	return count;
}

void SJF(int n,Process* pr,int verbose){
	int time=0;
	int deadtime=0;
	int inactiveTime=0;
	int totaltime=0;
	int deltatime;
	for(int i =0;i<n;i++){
		totaltime+=pr[i].CPUtime;
	}
	deltatime=1;
	int count =0;
	int smallest=0;
	for(time = 0; count != n; time++){
			smallest=n;
			pr[n].remaining=9999999;
			for(int i=0;i<n;i++){
				if(pr[i].arrival<=time && pr[smallest].remaining>pr[i].remaining && pr[i].CPUtime>0 ){
					smallest = i;
					

				}
			}
			if(pr[smallest].CPUtime>0)
				pr[smallest].active=1;
			pr[smallest].CPUtime--;
			if(smallest==n){
				continue;
			}
			
			if(verbose)
				printf("process %d executed 1 instant of time at time %d\n",smallest,time);
			//inactiveTime+=(countActives(pr,n));
			if(pr[smallest].CPUtime == 0)
            	{
	                  count++;
	                  int end = time + 1;
	                  int t=time;
	                  //time = time + end - pr[smallest].arrival -pr[smallest].remaining;
	                  deadtime+=(end-pr[smallest].arrival);
	                  if(verbose)
	                  	printf("process %d started in %d and ends at %d\n",pr[smallest].id, end-t,end);
	                  pr[smallest].active=0;
            	}
	}			
		printf("%d, %d\n",time,deadtime/n);	
}

void SRF(int n,Process* pr,int verbose){
	int time=0;
	int deadtime=0;
	int inactiveTime=0;
	int totaltime=0;
	int deltatime;
	for(int i =0;i<n;i++){
		totaltime+=pr[i].CPUtime;
	}
	deltatime=1;
	int count =0;
	int smallest=0;
	for(time = 0; count != n; time++){
			//printf("%d\n",time);
			smallest=n;
			pr[n].CPUtime=99999;
			for(int i=0;i<n;i++){
				if(pr[i].arrival<=time && pr[i].CPUtime<pr[smallest].CPUtime && pr[i].CPUtime>0){

					smallest = i;

				}
			}
			if(pr[smallest].CPUtime>0)
				pr[smallest].active=1;
			pr[smallest].CPUtime--;
			if(smallest==n){
				continue;
			}
			if(verbose)
				printf("process %d executed 1 instant of time at time %d\n",smallest,time);
			if(pr[smallest].CPUtime == 0){
	                  count++;
	                  int end = time + 1;
	                  int t=time;
	                  pr[smallest].active=0;
	                  //time = time + end - pr[smallest].arrival -pr[smallest].remaining;
	                  inactiveTime = inactiveTime + end - pr[smallest].arrival;
	                  if(verbose)
	                  	printf("process %d started and ends at %d\n",smallest ,end);
	                  deadtime+=(end-pr[smallest].arrival);
            	}
	}					
	printf("%d, %d \n",time,deadtime/n);			
	
}
int gaussian(double x, double s){
	double p=1-(s*s/x);
	int n=ceil(x/(1-s*s/x));
	int ans=0;

	for(int i =0;i<n;i++){

		if((double)rand()/RAND_MAX < p){

			ans++;
		}
	}
	return ans;

}

int deadtime2=0;
int auxiliar(int n,Process* pr,int verbose, int time,int q){

	int deltatime;
	int inactiveTime=0;
	int totaltime=0;

	for(int i =0;i<n;i++){
		totaltime+=pr[i].CPUtime;
	}
	deltatime=1;
	int count =0;
	int smallest=0;
	for(;count != n; time+=q){
			
			
			int i=smallest;
			
			while(!(pr[(smallest+1)%n].arrival<=time && pr[(smallest+1)%n].CPUtime>0)){

				smallest = (smallest+1)%n;
				if(smallest==i){
					break;
				}

			}
			
			if(pr[smallest].CPUtime>0)
				pr[smallest].active=1;
			pr[smallest].CPUtime-=q;

			if(verbose)
				printf("process %d executed 1 instant of time at time %d\n",smallest,time);
			if(pr[smallest].CPUtime <= 0){
	                  count++;
	                  int end = time + 1;
	                  int t=time;
	                  pr[smallest].active=0;
	                  //time = time + end - pr[smallest].arrival -pr[smallest].remaining;
	                  inactiveTime = inactiveTime + end - pr[smallest].arrival;
	                  if(verbose)
	                  	printf("process %d started and ends at %d\n",smallest ,end);
	                  deadtime2+=(end-pr[smallest].arrival);
            	}
	}					
	;

	return time;
}

int main(int argc, char *argv[]){
	printf("Hi this is a simulator of a FIFO SJF and SRF\n");
	Process* pr;
	Process* pr2;
	int n=atoi(argv[1]);
	double x=atof(argv[2]);
	int k=atoi(argv[3]);
	double s=atof(argv[4]);
	int verbose=atof(argv[5]);
	pr =(Process*)malloc(sizeof(Process)*(n+1));
	pr2=(Process*)malloc(sizeof(Process)*(n+1));

	Process** priority=(Process**)malloc(sizeof(Process*)*10);

	for(int i=0;i<10;i++){
		priority[i]=(Process*)malloc(sizeof(Process)*(n+1));
	}

	int size[10];
	for(int i =0;i<10;i++){
		size[i]=0;
	}
	for(int i = 0 ;i< n+1;i++){
		pr[i]=*((Process*)malloc(sizeof(Process)));
		pr[i].id=i;
		pr2[i].id=i;
		
		pr[i].arrival=rand()%k+1;

		pr2[i].arrival=pr[i].arrival;
		
		
		pr[i].CPUtime=pr[i].arrival+gaussian(x, s);
		pr2[i].CPUtime=pr[i].CPUtime;
		pr[i].remaining=pr[i].CPUtime;
		pr2[i].remaining=pr[i].remaining;
		
		pr[i].priority=rand()%10;
		pr2[i].priority=pr[i].priority;
		pr[i].active=0;
		pr2[i].active=0;
		priority[pr[i].priority][size[pr[i].priority]].arrival=pr[i].arrival;
		priority[pr[i].priority][size[pr[i].priority]].CPUtime=pr[i].CPUtime;
		priority[pr[i].priority][size[pr[i].priority]].remaining=pr[i].remaining;
		priority[pr[i].priority][size[pr[i].priority]].active=0;
		size[pr[i].priority]++;
		
	}
	
	printf("executing	FIFO\n");
	FIFO(n,pr,verbose);
	printf("executing	SJF\n");
	SJF(n,pr,verbose);
	printf("executing SRF\n");
	SRF(n,pr2,verbose);
	printf("executing MLF\n");
	int time=0;
	for(int i=0;i<10;i++){
		time=auxiliar(size[i],priority[i],verbose,time,1);
	}
	printf("%d, %d\n",time,deadtime2);
}