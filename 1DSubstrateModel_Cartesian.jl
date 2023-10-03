using Plots, DifferentialEquations, SpecialFunctions
gr()





function diff!(du,u,p,t)
dx,N,D,γ,λ=p


for i in 2:N-1
    D1i =  u[i,2]   
    D1ip = u[i+1,2] 
    D1im = u[i-1,2] 

    D2i =  u[i,1]*(1-u[i,1])   
    D2ip = u[i+1,1]*(1-u[i+1,1])
    D2im = u[i-1,1]*(1-u[i-1,1])
    du[i,1]=D*((D1i+D1ip)*(u[i+1,1]-u[i,1])-(D1i+D1im)*(u[i,1]-u[i-1,1]))/(2*dx^2)+D*((D2i+D2ip)*(u[i+1,2]-u[i,2])-(D2i+D2im)*(u[i,2]-u[i-1,2]))/(2*dx^2) + λ*u[i,1]*(1-u[i,1])
end
du[1,1]=0
du[N,1]=0

for i in 1:N
    if u[i,2] <1
    du[i,2]=γ*u[i,1]    
    else    
    du[i,2]=0.0
    end
end

  
end


function pdesolver(L,dx,N,T,u0,D,γ,λ)
p=(dx,N,D,γ,λ)
tspan=(0.0,maximum(T))
prob=ODEProblem(diff!,u0,tspan,p)
sol=solve(prob,Tsit5(),abstol=1e-12,reltol=1e-12,dtmax=1e-2,saveat=T);
return sol
end





L=300
T=[0,500,1000,1500,2000]
dx=0.1
N=Int(L/dx)+1
D=0.25;
γ=10/1;
λ=1/500;

u0=zeros(N,2);
xx=-L/2:dx:L/2
for i in 1:N
  if xx[i] <= 0
    u0[i,1]=1.0
  end
end




un=pdesolver(L,dx,N,T,u0,D,γ,λ) 
#p1=plot(xx,un[:,1,2],color=:green,lw=4,legend=false,xlims=(-40,20))
#p1=plot!(xx,un[:,2,2],lw=4,ylabel="s(x,t)",c=:orange,label=false,xlims=(-40,20))



q1=plot(xx,un[:,1,1],lw=4,ylabel="u(x,t)",c=:green,label=false)
q1=plot!(xx,un[:,2,1],lw=4,ylabel="s(x,t)",c=:orange,label=false)
q1=plot!(xx,un[:,1,2],lw=4,ylabel="u(x,t)",c=:green,label=false)
q1=plot!(xx,un[:,2,2],lw=4,ylabel="s(x,t)",c=:orange,label=false)
q1=plot!(xx,un[:,1,3],lw=4,ylabel="u(x,t)",c=:green,label=false)
q1=plot!(xx,un[:,2,3],lw=4,ylabel="s(x,t)",c=:orange,label=false)
q1=plot!(xx,un[:,1,4],lw=4,ylabel="u(x,t)",c=:green,label=false)
q1=plot!(xx,un[:,2,4],lw=4,ylabel="s(x,t)",c=:orange,label=false)


display(q1)
