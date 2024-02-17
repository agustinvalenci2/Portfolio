from collections import defaultdict
memo=dict()
ind=0
def spin(T,L,S,J):
    
    global memo,ind
    """
    Calculates SPIN
    """
    if memo.get(T[0]) ==None: ##if not is in memory
        if len(T) !=0:
            
            i=T[0]
            ans=float('inf')
            S[i]=-1 #set S[i] as -1
            
            ans1=S[i]*L[i]+sum([+S[i]*S[t[0]]*J[i,t[0]]+spin(t,L,S,J) for t in T[1]]) #calculates spin for S[i] =-1 using recursion
            S[i]=1 #set S[i] as 1
            ans2=S[i]*L[i]+sum([S[i]*S[t[0]]*J[i,t[0]]+spin(t,L,S,J) for t in T[1]]) #calculates spin for S[i] =1 using recursion
            
            if ans1<ans2: #if with S[i]=-1 is lower than S[i] = 1
                S[i]=-1 #set S[i] as -1
                ans=ans1 #set ans as spin with S[i]=-1
            else: #else 
                S[i]=1 #set S[i] as 1
                ans=ans2 #set ans as spin with S[i]=1
            memo[T[0]]=(ans)
    else: #if it is in memory
        ans=memo[T[0]] #get answer from memory
    return ans

def create_tree(u,G,T,visited):
    """
    Creates a tree form t<-[num, tree,tree] using graph G applying DFS algorithm
    """
    visited[u]=True #set as visited actual node u
    T[0]=u # add as node of tree a node of graph u
    for v in G[u]: # for all adyacent nodes from u
        if not visited[v]: # if not visited
            T[1].append([None,[]])
            create_tree(v,G,T[1][-1],visited) #will be a child of u



def main():
    l=input()
    while l[0]!='p':
      l=input()
    _,_,V,E=l.split()
    V=int(V)
    E=int(E)
    G=[[] for _ in range(V)]
    L=[0 for _ in G]
    S=[1 for _ in L]
    visited=[False for _ in S]
    J=dict()
    #Create a graph equivalent to the tree 
    for _ in range(E):
        u,v,w=list(map(int,input().split()))
        if u==v:
            L[u]=w
        else:
            G[u].append(v)
            G[v].append(u)
            J[(u,v)]=w
            J[(v,u)]=w
    
    T=[None,[]]        
    create_tree(0,G,T,visited)#create tree with source 0 (source is irrelevant)
    print(spin(T,L,S,J))#calculates spin for tree
    print("".join(['+' if s ==1 else '-' for s in S]))

main()
