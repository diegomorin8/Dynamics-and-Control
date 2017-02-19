close all
sym s 
G = tf(424,[1 22.49]);
G2 = tf(56.94,[1 21.28]);
step(G);
figure
step(G2);
