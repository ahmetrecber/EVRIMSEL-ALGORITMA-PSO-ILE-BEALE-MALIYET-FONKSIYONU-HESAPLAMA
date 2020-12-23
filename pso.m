clc;
clear;
close all;
%%Problem tanýmý
CostFunction= @(x) beale(x);
%tanýmlanmýþ maliyet fonksiyonu
nVar=7;     
%bilinmeyen deðiþken sayýsý
VarSize=[1,nVar]; 
%karar deðiþkenlerinin matris büyüklüðü
VarMin=-50;
%karar deðiþkenlerinin alt sýnýrý
VarMax=50;
%karar deðiþkenlerinin üst sýnýrý

%% PSO parametreleri
MaxIt=300;
%maksimum yineleme sayýsý
nPop=50;
%nüfus büyüklüðü (sürü boyutu)
w=1;
%Atalet katsayýsý
wdamp=0.80;
%sönüm faktörü
c1=1.775;
%kiþisel ivme katsayýsý
c2=2.8;
%sosyal ivme katsayýsý

%% Baþlatma
%parçacýklar için bir þablon oluþturma

empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
%popülasyon dizisi oluþturma
particle=repmat(empty_particle,nPop,1)
%referans için küresel bir en iyiyi yaratmak
GlobalBest.Cost=inf;
%nüfus üyelerini baþlat

for i=1:nPop
    %Rastgele çözüm üret
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    %hýzý baþlat
    particle(i).Velocity=zeros(VarSize);
    %Deðerlendirme
    particle(i).Cost=CostFunction(particle(i).Position);
    %kiþisel maliyeti güncelle
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    %genel olarak en iyisini güncelle
    if particle(i).Best.Cost<GlobalBest.Cost
        GlobalBest=particle(i).Best;
    end
end
%Her adýmda en iyi maliyetleri elde etmek için dizi
BestCosts=zeros(MaxIt,1);
%% PSO'nun Ana Döngüsü
for it=1:MaxIt
    for i=1:nPop
        %güncelleme hýzý
        particle(i).Velocity=w*particle(i).Velocity+c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)+c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        %güncelleme konumu
        particle(i).Position=particle(i).Position+particle(i).Velocity;
        %deðerlendirme
        particle(i).Cost=CostFunction(particle(i).Position);
        %kiþisel olarak en iyisini güncelle
        if particle(i).Cost<particle(i).Best.Cost
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            %genel olarak en iyisini güncelle
            if particle(i).Best.Cost<GlobalBest.Cost
                GlobalBest=particle(i).Best;
            end
        end
    end
    %en iyi maliyet deðerini sakla
    BestCosts(it)=GlobalBest.Cost;
    disp(['Iterations' num2str(it) 'BestCost--' num2str(BestCosts(it))])
    w=w*wdamp;
end

%% Sonuçlar

figure;
plot(BestCosts,'LineWidth',2)
xlabel('Iterations');
ylabel('Best Cost');
grid on;
