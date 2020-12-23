clc;
clear;
close all;
%%Problem tan�m�
CostFunction= @(x) beale(x);
%tan�mlanm�� maliyet fonksiyonu
nVar=7;     
%bilinmeyen de�i�ken say�s�
VarSize=[1,nVar]; 
%karar de�i�kenlerinin matris b�y�kl���
VarMin=-50;
%karar de�i�kenlerinin alt s�n�r�
VarMax=50;
%karar de�i�kenlerinin �st s�n�r�

%% PSO parametreleri
MaxIt=300;
%maksimum yineleme say�s�
nPop=50;
%n�fus b�y�kl��� (s�r� boyutu)
w=1;
%Atalet katsay�s�
wdamp=0.80;
%s�n�m fakt�r�
c1=1.775;
%ki�isel ivme katsay�s�
c2=2.8;
%sosyal ivme katsay�s�

%% Ba�latma
%par�ac�klar i�in bir �ablon olu�turma

empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
%pop�lasyon dizisi olu�turma
particle=repmat(empty_particle,nPop,1)
%referans i�in k�resel bir en iyiyi yaratmak
GlobalBest.Cost=inf;
%n�fus �yelerini ba�lat

for i=1:nPop
    %Rastgele ��z�m �ret
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    %h�z� ba�lat
    particle(i).Velocity=zeros(VarSize);
    %De�erlendirme
    particle(i).Cost=CostFunction(particle(i).Position);
    %ki�isel maliyeti g�ncelle
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    %genel olarak en iyisini g�ncelle
    if particle(i).Best.Cost<GlobalBest.Cost
        GlobalBest=particle(i).Best;
    end
end
%Her ad�mda en iyi maliyetleri elde etmek i�in dizi
BestCosts=zeros(MaxIt,1);
%% PSO'nun Ana D�ng�s�
for it=1:MaxIt
    for i=1:nPop
        %g�ncelleme h�z�
        particle(i).Velocity=w*particle(i).Velocity+c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)+c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        %g�ncelleme konumu
        particle(i).Position=particle(i).Position+particle(i).Velocity;
        %de�erlendirme
        particle(i).Cost=CostFunction(particle(i).Position);
        %ki�isel olarak en iyisini g�ncelle
        if particle(i).Cost<particle(i).Best.Cost
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            %genel olarak en iyisini g�ncelle
            if particle(i).Best.Cost<GlobalBest.Cost
                GlobalBest=particle(i).Best;
            end
        end
    end
    %en iyi maliyet de�erini sakla
    BestCosts(it)=GlobalBest.Cost;
    disp(['Iterations' num2str(it) 'BestCost--' num2str(BestCosts(it))])
    w=w*wdamp;
end

%% Sonu�lar

figure;
plot(BestCosts,'LineWidth',2)
xlabel('Iterations');
ylabel('Best Cost');
grid on;
