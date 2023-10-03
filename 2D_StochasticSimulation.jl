using Plots
using Random
using LinearAlgebra
function Stochastic(LX,LY,T,Tplot,PM,PP,γ)
    AA=zeros(LX,LY)
    GG=zeros(LX,LY)
    Gplot=zeros(4,LX,LY)
    RR = 150

    for i in 1:LX
        for j in 1:LY
            S=rand(1)
               if ((i-1)-LX/2)^2 + ((j-1)-LY/2)^2 <= RR^2 && S[1] < 0.42
            AA[i,j]=1.0
               end
        end
    end


    
    Q=Int(sum(AA))

    pos0=zeros(3*Q,2)
    pos1=zeros(3*Q,2)
    pos2=zeros(3*Q,2)
    pos3=zeros(3*Q,2)
        agent=0
        for i in 1:LX
            for j in 1:LY
                if AA[i,j] == 1.0
                agent = agent+1
                pos0[agent,1]=i
                pos0[agent,2]=j
                end 
            end
        end

    
    for kk in 1:T
       
        for i in 1:LX
            for j in 1:LY
                GG[i,j] = min(1, GG[i,j] + AA[i,j]*γ);
                #GG[i,j]=1
            end
        end

        count = 0
        while count  < Q
            II =rand(1:LX)
            JJ=rand(1:LY)
            if AA[II,JJ] > 0.0 && II>1 && II<LX && JJ > 1 && JJ < LY 
            count=count+1
            R =rand(1)
            S=rand(1)
                if AA[II-1,JJ] == 0.0 && R[1] > 0 && R[1]<=1/4 && S[1] <=PM*GG[II,JJ]
                AA[II,JJ]=0.0
                AA[II-1,JJ]=1.0
                elseif AA[II+1,JJ] == 0.0 && R[1] > 1/4 && R[1]<=2/4  && S[1] <=PM*GG[II,JJ]
                AA[II,JJ]=0.0
                AA[II+1,JJ]=1.0
                elseif AA[II,JJ-1] == 0.0 && R[1] > 2/4 && R[1]<=3/4  && S[1] <=PM*GG[II,JJ]
                AA[II,JJ]=0.0
                AA[II,JJ-1]=1.0
                elseif AA[II,JJ+1] == 0.0 && R[1] > 3/4 && R[1]<=4/4  && S[1] <=PM*GG[II,JJ]
                AA[II,JJ]=0.0
                AA[II,JJ+1]=1.0
                end

            end
        end

        count = 0
        while count  < Q
            II =rand(1:LX)
            JJ=rand(1:LY)
            if AA[II,JJ] > 0.0 && II>1 && II<LX && JJ > 1 && JJ < LY 
            count=count+1
            R =rand(1)
            S=rand(1)
                if AA[II-1,JJ] == 0.0 && R[1] > 0 && R[1]<=1/4 && S[1] <=PP
                AA[II-1,JJ]=1.0
                elseif AA[II+1,JJ] == 0.0 && R[1] > 1/4 && R[1]<=2/4  && S[1] <=PP
                AA[II+1,JJ]=1.0
                elseif AA[II,JJ-1] == 0.0 && R[1] > 2/4 && R[1]<=3/4  && S[1] <=PP
                AA[II,JJ-1]=1.0
                elseif AA[II,JJ+1] == 0.0 && R[1] > 3/4 && R[1]<=4/4  && S[1] <=PP
                AA[II,JJ+1]=1.0
                end

            end
        end
        








        
        

        Q=Int(sum(AA))
        if kk == Tplot[1]
            agent=0
            for i in 1:LX
                for j in 1:LY
                    if AA[i,j] == 1.0
                    agent = agent+1
                    pos1[agent,1]=i
                    pos1[agent,2]=j
                    end 
                end
            end
        Gplot[1,:,:]=GG
        elseif kk == Tplot[2]
            agent=0
            for i in 1:LX
                for j in 1:LY
                    if AA[i,j] == 1.0
                        agent = agent+1
                        pos2[agent,1]=i
                        pos2[agent,2]=j
                    end 
                end
            end
        Gplot[2,:,:]=GG
        elseif kk == Tplot[3]
            agent=0
            for i in 1:LX
                for j in 1:LY
                    if AA[i,j] == 1.0
                        agent = agent+1
                        pos3[agent,1]=i
                        pos3[agent,2]=j
                    end 
                end
            end
        Gplot[3,:,:]=GG       
        end


    end

return pos0,pos1,pos2,pos3
end





LX=500
LY=500
PM=1.0
PP=1/500
γ=1/100
T=1:1500
Tplot=[500,1000,1500]


(pos0,pos1,pos2,pos3)=Stochastic(LX,LY,maximum(T),Tplot,PM,PP,γ)


q0=scatter(pos0[:,1],pos0[:,2],markersize=1,markershape=:circle, markercolor=:red,msw=0,xlims=(0,LX),ylims=(0,LY),legend=false,aspect_ratio=:equal)
q1=scatter(pos1[:,1],pos1[:,2],markersize=1,markershape=:circle, markercolor=:red,msw=0,xlims=(0,LX),ylims=(0,LY),legend=false,aspect_ratio=:equal)
q2=scatter(pos2[:,1],pos2[:,2],markersize=1,markershape=:circle, markercolor=:red,msw=0,xlims=(0,LX),ylims=(0,LY),legend=false,aspect_ratio=:equal)
q3=scatter(pos3[:,1],pos3[:,2],markersize=1,markershape=:circle, markercolor=:red,msw=0,xlims=(0,LX),ylims=(0,LY),legend=false,aspect_ratio=:equal)
q4=scatter(pos3[:,1],pos3[:,2],markersize=1,markershape=:circle, markercolor=:red,msw=0,xlims=(0,LX),ylims=(0,LY),legend=false,aspect_ratio=:equal)
q5=plot(q0,q3,q3,q3,layout=(2,2))
display(q5)
savefig(q5,"Dot.pdf") 


# p0=contourf(1:LX,1:LY,gg[1,:,:],lw=0,xlabel="x",ylabel="y",c=:greens,colorbar=false,aspect_ratio=:equal)
# p1=contourf(1:LX,1:LY,gg[2,:,:],lw=0,xlabel="x",ylabel="y",c=:greens,colorbar=false,aspect_ratio=:equal)
# p2=contourf(1:LX,1:LY,gg[3,:,:],lw=0,xlabel="x",ylabel="y",c=:greens,colorbar=false,aspect_ratio=:equal)
# p3=contourf(1:LX,1:LY,gg[4,:,:],lw=0,xlabel="x",ylabel="y",c=:greens,colorbar=false,aspect_ratio=:equal)
# p4=contourf(1:LX,1:LY,gg[4,:,:],lw=0,xlabel="x",ylabel="y",c=:greens,colorbar=false,aspect_ratio=:equal)
# p5=plot(p0,p1,p2,p3,layout=(2,2))
# display(p5)