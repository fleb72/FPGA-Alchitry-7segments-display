# FPGA-Alchitry-7segments-display
Description d'un afficheur 7-segments en Verilog

Démonstration mettant en œuvre un afficheur multiplexé 7-segments à quatre digits (anode commune) en langage Verilog.
La plateforme est une carte *Alchitry Au* sur laquelle est enfichée la carte d'extension *Alchitry Io*.
l'EDI utilisé est Alchitry Labs (v1.2.6).

[![Alchitry 7-seg display](https://img.youtube.com/vi/yRJb7t5qiEA/0.jpg)](https://www.youtube.com/watch?v=yRJb7t5qiEA)

![Vivado analysis RTL](rtl-analysis2.png?raw=true "Vivado analysis RTL")

En sortie tout à droite :
io_sel[3:0] : bus de sortie vers les 4 anodes.
io_seg[7:0] : bus de sortie vers les 8 cathodes (les 7 segments + point décimal).

Le module principal *au_top.v* est donc responsable de la structure du projet en instanciant les différents modules.

Le module *reset_conditioner.v* est proposé directement par l'EDI Alchitry Labs. L’instance *rst_cond* permet de « nettoyer » le signal d’entrée, provenant de l’appui sur le bouton *Reset* en surface de la carte (signal *rst_n*), et de le synchroniser sur le front montant de l’horloge (signal *clk*). Ce signal conditionné servira au besoin à réinitialiser simultanément tous les composants souhaités.

Le module *tenth_second_counter.v* génère en sortie un nombre entier sur 14 bits (pour afficher des nombres entre 0 et 9999), initialement à zéro, et qui va s'incrémenter tous les dixièmes de seconde. L'appui sur le bouton *Reset* provoque la remise à zéro du compteur, et maintenir l'appui sur le bouton *io_button[1]* du shield va stopper le chronomètre.

Le module *seven_seg_multiplexing.v* prend en charge l'affichage du nombre *displayed_number* qui se présente à l'entrée. 


