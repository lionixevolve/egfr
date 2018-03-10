library("ggplot2")
library(RColorBrewer)
library(grid)
library(gridExtra)
colores.imam <- brewer.pal(11, "Spectral")
####### Get & clean data #######
# get data
im.list <- read.table("im.list")
am.list <- read.table("am.list")
# asa of the original PDBs
im.asa <- data.frame(t(read.table("im_originals_asa")))
am.asa <- data.frame(t(read.table("am_originals_asa")))
# svd
asa.im.svd.1 <- data.frame(t(read.table("im_mtx_asa_vec1")))
asa.im.svd.2 <- data.frame(t(read.table("im_mtx_asa_vec2")))
asa.am.svd.1 <- data.frame(t(read.table("am_mtx_asa_vec1")))
asa.am.svd.2 <- data.frame(t(read.table("am_mtx_asa_vec2")))
# modes
asa.im.mode.1 <- data.frame(t(read.table("im_mtx_asa_vecmode1")))
asa.im.mode.2 <- data.frame(t(read.table("im_mtx_asa_vecmode2")))
asa.am.mode.1 <- data.frame(t(read.table("am_mtx_asa_vecmode1")))
asa.am.mode.2 <- data.frame(t(read.table("am_mtx_asa_vecmode2")))
# main mode
asa.im.main <- data.frame(t(read.table("im_mtx_asa_vecmain")))
asa.am.main <- data.frame(t(read.table("am_mtx_asa_vecmain")))

####### Process #######

### Explore the appropiate displacement

# SVD
# IM
dif.asa.im.svd.1 = rbind((asa.im.svd.1[2, ] - asa.im.svd.1[1, ]),
                         (asa.im.svd.1[3, ] - asa.im.svd.1[2, ]),
                         (asa.im.svd.1[4, ] - asa.im.svd.1[3, ]),
                         (asa.im.svd.1[5, ] - asa.im.svd.1[4, ]) / 2,
                         (asa.im.svd.1[6, ] - asa.im.svd.1[5, ]) / 2,
                         (asa.im.svd.1[8, ] - asa.im.svd.1[7, ]) / 10,
                         (asa.im.svd.1[9, ] - asa.im.svd.1[8, ]) / 10,
                         (asa.im.svd.1[10, ] - asa.im.svd.1[9, ]) / 10,
                         (asa.im.svd.1[11, ] - asa.im.svd.1[10, ]) / 20,
                         (asa.im.svd.1[12, ] - asa.im.svd.1[11, ]) / 20)

dif.asa.im.svd.2 = rbind((asa.im.svd.2[2, ] - asa.im.svd.2[1, ]),
                         (asa.im.svd.2[3, ] - asa.im.svd.2[2, ]),
                         (asa.im.svd.2[4, ] - asa.im.svd.2[3, ]),
                         (asa.im.svd.2[5, ] - asa.im.svd.2[4, ]) / 2,
                         (asa.im.svd.2[6, ] - asa.im.svd.2[5, ]) / 2,
                         (asa.im.svd.2[8, ] - asa.im.svd.2[7, ]) / 10,
                         (asa.im.svd.2[9, ] - asa.im.svd.2[8, ]) / 10,
                         (asa.im.svd.2[10, ] - asa.im.svd.2[9, ]) / 10,
                         (asa.im.svd.2[11, ] - asa.im.svd.2[10, ]) / 20,
                         (asa.im.svd.2[12, ] - asa.im.svd.2[11, ]) / 20)
# AM
dif.asa.am.svd.1 = rbind((asa.am.svd.1[2, ] - asa.am.svd.1[1, ]),
                         (asa.am.svd.1[3, ] - asa.am.svd.1[2, ]),
                         (asa.am.svd.1[4, ] - asa.am.svd.1[3, ]),
                         (asa.am.svd.1[5, ] - asa.am.svd.1[4, ]) / 2,
                         (asa.am.svd.1[6, ] - asa.am.svd.1[5, ]) / 2,
                         (asa.am.svd.1[8, ] - asa.am.svd.1[7, ]) / 10,
                         (asa.am.svd.1[9, ] - asa.am.svd.1[8, ]) / 10,
                         (asa.am.svd.1[10, ] - asa.am.svd.1[9, ]) / 10,
                         (asa.am.svd.1[11, ] - asa.am.svd.1[10, ]) / 20,
                         (asa.am.svd.1[12, ] - asa.am.svd.1[11, ]) / 20)
dif.asa.am.svd.2 = rbind((asa.am.svd.2[2, ] - asa.am.svd.2[1, ]),
                         (asa.am.svd.2[3, ] - asa.am.svd.2[2, ]),
                         (asa.am.svd.2[4, ] - asa.am.svd.2[3, ]),
                         (asa.am.svd.2[5, ] - asa.am.svd.2[4, ]) / 2,
                         (asa.am.svd.2[6, ] - asa.am.svd.2[5, ]) / 2,
                         (asa.am.svd.2[8, ] - asa.am.svd.2[7, ]) / 10,
                         (asa.am.svd.2[9, ] - asa.am.svd.2[8, ]) / 10,
                         (asa.am.svd.2[10, ] - asa.am.svd.2[9, ]) / 10,
                         (asa.am.svd.2[11, ] - asa.am.svd.2[10, ]) / 20,
                         (asa.am.svd.2[12, ] - asa.am.svd.2[11, ]) / 20)
# Modes
# IM
dif.asa.im.mode.1 = rbind((asa.im.mode.1[2, ] - asa.im.mode.1[1, ]),
                          (asa.im.mode.1[3, ] - asa.im.mode.1[2, ]),
                          (asa.im.mode.1[4, ] - asa.im.mode.1[3, ]),
                          (asa.im.mode.1[5, ] - asa.im.mode.1[4, ]) / 2,
                          (asa.im.mode.1[6, ] - asa.im.mode.1[5, ]) / 2,
                          (asa.im.mode.1[8, ] - asa.im.mode.1[7, ]) / 10,
                          (asa.im.mode.1[9, ] - asa.im.mode.1[8, ]) / 10,
                          (asa.im.mode.1[10, ] - asa.im.mode.1[9, ]) / 10,
                          (asa.im.mode.1[11, ] - asa.im.mode.1[10, ]) / 20,
                          (asa.im.mode.1[12, ] - asa.im.mode.1[11, ]) / 20)
dif.asa.im.mode.2 = rbind((asa.im.mode.2[2, ] - asa.im.mode.2[1, ]),
                          (asa.im.mode.2[3, ] - asa.im.mode.2[2, ]),
                          (asa.im.mode.2[4, ] - asa.im.mode.2[3, ]),
                          (asa.im.mode.2[5, ] - asa.im.mode.2[4, ]) / 2,
                          (asa.im.mode.2[6, ] - asa.im.mode.2[5, ]) / 2,
                          (asa.im.mode.2[8, ] - asa.im.mode.2[7, ]) / 10,
                          (asa.im.mode.2[9, ] - asa.im.mode.2[8, ]) / 10,
                          (asa.im.mode.2[10, ] - asa.im.mode.2[9, ]) / 10,
                          (asa.im.mode.2[11, ] - asa.im.mode.2[10, ]) / 20,
                          (asa.im.mode.2[12, ] - asa.im.mode.2[11, ]) / 20)
# AM
dif.asa.am.mode.1 = rbind((asa.am.mode.1[2, ] - asa.am.mode.1[1, ]),
                          (asa.am.mode.1[3, ] - asa.am.mode.1[2, ]),
                          (asa.am.mode.1[4, ] - asa.am.mode.1[3, ]),
                          (asa.am.mode.1[5, ] - asa.am.mode.1[4, ]) / 2,
                          (asa.am.mode.1[6, ] - asa.am.mode.1[5, ]) / 2,
                          (asa.am.mode.1[8, ] - asa.am.mode.1[7, ]) / 10,
                          (asa.am.mode.1[9, ] - asa.am.mode.1[8, ]) / 10,
                          (asa.am.mode.1[10, ] - asa.am.mode.1[9, ]) / 10,
                          (asa.am.mode.1[11, ] - asa.am.mode.1[10, ]) / 20,
                          (asa.am.mode.1[12, ] - asa.am.mode.1[11, ]) / 20)
dif.asa.im.mode.2 = rbind((asa.im.mode.2[2, ] - asa.im.mode.2[1, ]),
                          (asa.im.mode.2[3, ] - asa.im.mode.2[2, ]),
                          (asa.im.mode.2[4, ] - asa.im.mode.2[3, ]),
                          (asa.im.mode.2[5, ] - asa.im.mode.2[4, ]) / 2,
                          (asa.im.mode.2[6, ] - asa.im.mode.2[5, ]) / 2,
                          (asa.im.mode.2[8, ] - asa.im.mode.2[7, ]) / 10,
                          (asa.im.mode.2[9, ] - asa.im.mode.2[8, ]) / 10,
                          (asa.im.mode.2[10, ] - asa.im.mode.2[9, ]) / 10,
                          (asa.im.mode.2[11, ] - asa.im.mode.2[10, ]) / 20,
                          (asa.im.mode.2[12, ] - asa.im.mode.2[11, ]) / 20)

# Main mode
# IM
dif.asa.im.main = rbind((asa.im.main[2, ] - asa.im.main[1, ]),
                        (asa.im.main[3, ] - asa.im.main[2, ]),
                        (asa.im.main[4, ] - asa.im.main[3, ]),
                        (asa.im.main[5, ] - asa.im.main[4, ]) / 2,
                        (asa.im.main[6, ] - asa.im.main[5, ]) / 2,
                        (asa.im.main[8, ] - asa.im.main[7, ]) / 10,
                        (asa.im.main[9, ] - asa.im.main[8, ]) / 10,
                        (asa.im.main[10, ] - asa.im.main[9, ]) / 10,
                        (asa.im.main[11, ] - asa.im.main[10, ]) / 20,
                        (asa.im.main[12, ] - asa.im.main[11, ]) / 20)
# AM
dif.asa.am.main = rbind((asa.am.main[2, ] - asa.am.main[1, ]),
                        (asa.am.main[3, ] - asa.am.main[2, ]),
                        (asa.am.main[4, ] - asa.am.main[3, ]),
                        (asa.am.main[5, ] - asa.am.main[4, ]) / 2,
                        (asa.am.main[6, ] - asa.am.main[5, ]) / 2,
                        (asa.am.main[8, ] - asa.am.main[7, ]) / 10,
                        (asa.am.main[9, ] - asa.am.main[8, ]) / 10,
                        (asa.am.main[10, ] - asa.am.main[9, ]) / 10,
                        (asa.am.main[11, ] - asa.am.main[10, ]) / 20,
                        (asa.am.main[12, ] - asa.am.main[11, ]) / 20)

####### Results #######

# Compile in dataframes
asa.mode1.1 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[1, ]) / 1,
                                                 (am.asa - asa.am.mode.1[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.mode1.2 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[2, ]) / 2,
                                                 (am.asa - asa.am.mode.1[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.mode1.3 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[3, ]) / 3,
                                                 (am.asa - asa.am.mode.1[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.mode1.4 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[4, ]) / 4,
                                                 (am.asa - asa.am.mode.1[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.mode1.6 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[5, ]) / 5,
                                                 (am.asa - asa.am.mode.1[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.mode1.8 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.1[6, ]) / 6,
                                                 (am.asa - asa.am.mode.1[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

asa.mode2.1 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[1, ]) / 1,
                                                  (am.asa - asa.am.mode.2[1, ]) / 1)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
asa.mode2.2 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[2, ]) / 2,
                                                  (am.asa - asa.am.mode.2[2, ]) / 2)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
asa.mode2.3 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[3, ]) / 3,
                                                  (am.asa - asa.am.mode.2[3, ]) / 3)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
asa.mode2.4 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[4, ]) / 4,
                                                  (am.asa - asa.am.mode.2[4, ]) / 4)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
asa.mode2.6 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[5, ]) / 5,
                                                  (am.asa - asa.am.mode.2[5, ]) / 5)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
asa.mode2.8 = data.frame(Value = simplify2array(c((im.asa - asa.im.mode.2[6, ]) / 6,
                                                  (am.asa - asa.am.mode.2[6, ]) / 6)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))

asa.svd1.1 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[1, ]) / 1,
                                                 (am.asa - asa.am.svd.1[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd1.2 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[2, ]) / 2,
                                                 (am.asa - asa.am.svd.1[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd1.3 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[3, ]) / 3,
                                                 (am.asa - asa.am.svd.1[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd1.4 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[4, ]) / 4,
                                                 (am.asa - asa.am.svd.1[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd1.6 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[5, ]) / 5,
                                                 (am.asa - asa.am.svd.1[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd1.8 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.1[6, ]) / 6,
                                                 (am.asa - asa.am.svd.1[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

asa.svd2.1 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[1, ]) / 1,
                                                 (am.asa - asa.am.svd.2[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd2.2 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[2, ]) / 2,
                                                 (am.asa - asa.am.svd.2[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd2.3 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[3, ]) / 3,
                                                 (am.asa - asa.am.svd.2[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd2.4 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[4, ]) / 4,
                                                 (am.asa - asa.am.svd.2[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd2.6 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[5, ]) / 5,
                                                 (am.asa - asa.am.svd.2[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.svd2.8 = data.frame(Value = simplify2array(c((im.asa - asa.im.svd.2[6, ]) / 6,
                                                 (am.asa - asa.am.svd.2[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

asa.main.1 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[1, ]) / 1,
                                                 (am.asa - asa.am.main[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.main.2 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[2, ]) / 2,
                                                 (am.asa - asa.am.main[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.main.3 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[3, ]) / 3,
                                                 (am.asa - asa.am.main[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.main.4 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[4, ]) / 4,
                                                 (am.asa - asa.am.main[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.main.6 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[5, ]) / 5,
                                                 (am.asa - asa.am.main[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
asa.main.8 = data.frame(Value = simplify2array(c((im.asa - asa.im.main[6, ]) / 6,
                                                 (am.asa - asa.am.main[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

# Now plot it!
pdf("asa_mode_1.pdf", height = 8, width = 15)
ggplot(asa.mode1.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 1")
ggplot(asa.mode1.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 2")
ggplot(asa.mode1.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 3")
ggplot(asa.mode1.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 4")
ggplot(asa.mode1.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  labs(title = "Mode 1, displacement 6")
ggplot(asa.mode1.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 8")
dev.off()
#
pdf("asa_mode_2.pdf", height = 8, width = 15)
ggplot(asa.mode2.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 1")
ggplot(asa.mode2.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 2")
ggplot(asa.mode2.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 3")
ggplot(asa.mode2.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 4")
ggplot(asa.mode2.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "Mode 1, displacement 6")
ggplot(asa.mode2.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 8")
dev.off()

### Mode

pdf("asa_svd_1.pdf", height = 8, width = 15)
ggplot(asa.svd1.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 1")
ggplot(asa.svd1.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 2")
ggplot(asa.svd1.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 3")
ggplot(asa.svd1.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 4")
ggplot(asa.svd1.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "Mode 1, displacement 6")
ggplot(asa.svd1.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 8")
dev.off()
#
pdf("asa_svd_2.pdf", height = 8, width = 15)
ggplot(asa.svd2.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 1")
ggplot(asa.svd2.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 2")
ggplot(asa.svd2.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 3")
ggplot(asa.svd2.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 2, displacement 4")
ggplot(asa.svd2.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "Mode 2, displacement 6")
ggplot(asa.svd2.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 2, displacement 8")
dev.off()
#
pdf("asa_main.pdf", height = 8, width = 15)
ggplot(asa.main.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 1")
ggplot(asa.main.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 2")
ggplot(asa.main.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 3")
ggplot(asa.main.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 4")
ggplot(asa.main.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 6")
ggplot(asa.main.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 8")
dev.off()


### Ahora veo los promedios
# IM
matrix(c(mean(simplify2array(im.asa - asa.im.mode.1[3, ])),
mean(simplify2array(im.asa - asa.im.mode.2[3, ])),
mean(simplify2array(im.asa - asa.im.main[3, ])),
mean(simplify2array(im.asa - asa.im.svd.1[3, ])),
mean(simplify2array(im.asa - asa.im.svd.2[3, ])),
# AM
mean(simplify2array(am.asa - asa.am.mode.1[3, ])),
mean(simplify2array(am.asa - asa.am.mode.2[3, ])),
mean(simplify2array(am.asa - asa.am.main[3, ])),
mean(simplify2array(am.asa - asa.am.svd.1[3, ])),
mean(simplify2array(am.asa - asa.am.svd.2[3, ]))), ncol = 2) / 3


