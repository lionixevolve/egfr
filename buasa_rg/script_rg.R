library("ggplot2")
library(RColorBrewer)
library(grid)
library(gridExtra)
colores.imam <- brewer.pal(11, "Spectral")
####### Get & clean data #######
# get data
im.list <- read.table("im.list")
am.list <- read.table("am.list")
# rg of the original PDBs
im.rg <- data.frame(t(read.table("im_originals_rg")))
am.rg <- data.frame(t(read.table("am_originals_rg")))
# svd
rg.im.svd.1 <- data.frame(t(read.table("im_mtx_rg_vec1")))
rg.im.svd.2 <- data.frame(t(read.table("im_mtx_rg_vec2")))
rg.am.svd.1 <- data.frame(t(read.table("am_mtx_rg_vec1")))
rg.am.svd.2 <- data.frame(t(read.table("am_mtx_rg_vec2")))
# modes
rg.im.mode.1 <- data.frame(t(read.table("im_mtx_rg_vecmode1")))
rg.im.mode.2 <- data.frame(t(read.table("im_mtx_rg_vecmode2")))
rg.am.mode.1 <- data.frame(t(read.table("am_mtx_rg_vecmode1")))
rg.am.mode.2 <- data.frame(t(read.table("am_mtx_rg_vecmode2")))
# main mode
rg.im.main <- data.frame(t(read.table("im_mtx_rg_vecmain")))
rg.am.main <- data.frame(t(read.table("am_mtx_rg_vecmain")))

####### Process #######

### Explore the appropiate displacement

# SVD
# IM
dif.rg.im.svd.1 = rbind((rg.im.svd.1[2, ] - rg.im.svd.1[1, ]),
                         (rg.im.svd.1[3, ] - rg.im.svd.1[2, ]),
                         (rg.im.svd.1[4, ] - rg.im.svd.1[3, ]),
                         (rg.im.svd.1[5, ] - rg.im.svd.1[4, ]) / 2,
                         (rg.im.svd.1[6, ] - rg.im.svd.1[5, ]) / 2,
                         (rg.im.svd.1[8, ] - rg.im.svd.1[7, ]) / 10,
                         (rg.im.svd.1[9, ] - rg.im.svd.1[8, ]) / 10,
                         (rg.im.svd.1[10, ] - rg.im.svd.1[9, ]) / 10,
                         (rg.im.svd.1[11, ] - rg.im.svd.1[10, ]) / 20,
                         (rg.im.svd.1[12, ] - rg.im.svd.1[11, ]) / 20)

dif.rg.im.svd.2 = rbind((rg.im.svd.2[2, ] - rg.im.svd.2[1, ]),
                         (rg.im.svd.2[3, ] - rg.im.svd.2[2, ]),
                         (rg.im.svd.2[4, ] - rg.im.svd.2[3, ]),
                         (rg.im.svd.2[5, ] - rg.im.svd.2[4, ]) / 2,
                         (rg.im.svd.2[6, ] - rg.im.svd.2[5, ]) / 2,
                         (rg.im.svd.2[8, ] - rg.im.svd.2[7, ]) / 10,
                         (rg.im.svd.2[9, ] - rg.im.svd.2[8, ]) / 10,
                         (rg.im.svd.2[10, ] - rg.im.svd.2[9, ]) / 10,
                         (rg.im.svd.2[11, ] - rg.im.svd.2[10, ]) / 20,
                         (rg.im.svd.2[12, ] - rg.im.svd.2[11, ]) / 20)
# AM
dif.rg.am.svd.1 = rbind((rg.am.svd.1[2, ] - rg.am.svd.1[1, ]),
                         (rg.am.svd.1[3, ] - rg.am.svd.1[2, ]),
                         (rg.am.svd.1[4, ] - rg.am.svd.1[3, ]),
                         (rg.am.svd.1[5, ] - rg.am.svd.1[4, ]) / 2,
                         (rg.am.svd.1[6, ] - rg.am.svd.1[5, ]) / 2,
                         (rg.am.svd.1[8, ] - rg.am.svd.1[7, ]) / 10,
                         (rg.am.svd.1[9, ] - rg.am.svd.1[8, ]) / 10,
                         (rg.am.svd.1[10, ] - rg.am.svd.1[9, ]) / 10,
                         (rg.am.svd.1[11, ] - rg.am.svd.1[10, ]) / 20,
                         (rg.am.svd.1[12, ] - rg.am.svd.1[11, ]) / 20)
dif.rg.am.svd.2 = rbind((rg.am.svd.2[2, ] - rg.am.svd.2[1, ]),
                         (rg.am.svd.2[3, ] - rg.am.svd.2[2, ]),
                         (rg.am.svd.2[4, ] - rg.am.svd.2[3, ]),
                         (rg.am.svd.2[5, ] - rg.am.svd.2[4, ]) / 2,
                         (rg.am.svd.2[6, ] - rg.am.svd.2[5, ]) / 2,
                         (rg.am.svd.2[8, ] - rg.am.svd.2[7, ]) / 10,
                         (rg.am.svd.2[9, ] - rg.am.svd.2[8, ]) / 10,
                         (rg.am.svd.2[10, ] - rg.am.svd.2[9, ]) / 10,
                         (rg.am.svd.2[11, ] - rg.am.svd.2[10, ]) / 20,
                         (rg.am.svd.2[12, ] - rg.am.svd.2[11, ]) / 20)
# Modes
# IM
dif.rg.im.mode.1 = rbind((rg.im.mode.1[2, ] - rg.im.mode.1[1, ]),
                          (rg.im.mode.1[3, ] - rg.im.mode.1[2, ]),
                          (rg.im.mode.1[4, ] - rg.im.mode.1[3, ]),
                          (rg.im.mode.1[5, ] - rg.im.mode.1[4, ]) / 2,
                          (rg.im.mode.1[6, ] - rg.im.mode.1[5, ]) / 2,
                          (rg.im.mode.1[8, ] - rg.im.mode.1[7, ]) / 10,
                          (rg.im.mode.1[9, ] - rg.im.mode.1[8, ]) / 10,
                          (rg.im.mode.1[10, ] - rg.im.mode.1[9, ]) / 10,
                          (rg.im.mode.1[11, ] - rg.im.mode.1[10, ]) / 20,
                          (rg.im.mode.1[12, ] - rg.im.mode.1[11, ]) / 20)
dif.rg.im.mode.2 = rbind((rg.im.mode.2[2, ] - rg.im.mode.2[1, ]),
                          (rg.im.mode.2[3, ] - rg.im.mode.2[2, ]),
                          (rg.im.mode.2[4, ] - rg.im.mode.2[3, ]),
                          (rg.im.mode.2[5, ] - rg.im.mode.2[4, ]) / 2,
                          (rg.im.mode.2[6, ] - rg.im.mode.2[5, ]) / 2,
                          (rg.im.mode.2[8, ] - rg.im.mode.2[7, ]) / 10,
                          (rg.im.mode.2[9, ] - rg.im.mode.2[8, ]) / 10,
                          (rg.im.mode.2[10, ] - rg.im.mode.2[9, ]) / 10,
                          (rg.im.mode.2[11, ] - rg.im.mode.2[10, ]) / 20,
                          (rg.im.mode.2[12, ] - rg.im.mode.2[11, ]) / 20)
# AM
dif.rg.am.mode.1 = rbind((rg.am.mode.1[2, ] - rg.am.mode.1[1, ]),
                          (rg.am.mode.1[3, ] - rg.am.mode.1[2, ]),
                          (rg.am.mode.1[4, ] - rg.am.mode.1[3, ]),
                          (rg.am.mode.1[5, ] - rg.am.mode.1[4, ]) / 2,
                          (rg.am.mode.1[6, ] - rg.am.mode.1[5, ]) / 2,
                          (rg.am.mode.1[8, ] - rg.am.mode.1[7, ]) / 10,
                          (rg.am.mode.1[9, ] - rg.am.mode.1[8, ]) / 10,
                          (rg.am.mode.1[10, ] - rg.am.mode.1[9, ]) / 10,
                          (rg.am.mode.1[11, ] - rg.am.mode.1[10, ]) / 20,
                          (rg.am.mode.1[12, ] - rg.am.mode.1[11, ]) / 20)
dif.rg.im.mode.2 = rbind((rg.im.mode.2[2, ] - rg.im.mode.2[1, ]),
                          (rg.im.mode.2[3, ] - rg.im.mode.2[2, ]),
                          (rg.im.mode.2[4, ] - rg.im.mode.2[3, ]),
                          (rg.im.mode.2[5, ] - rg.im.mode.2[4, ]) / 2,
                          (rg.im.mode.2[6, ] - rg.im.mode.2[5, ]) / 2,
                          (rg.im.mode.2[8, ] - rg.im.mode.2[7, ]) / 10,
                          (rg.im.mode.2[9, ] - rg.im.mode.2[8, ]) / 10,
                          (rg.im.mode.2[10, ] - rg.im.mode.2[9, ]) / 10,
                          (rg.im.mode.2[11, ] - rg.im.mode.2[10, ]) / 20,
                          (rg.im.mode.2[12, ] - rg.im.mode.2[11, ]) / 20)

# Main mode
# IM
dif.rg.im.main = rbind((rg.im.main[2, ] - rg.im.main[1, ]),
                        (rg.im.main[3, ] - rg.im.main[2, ]),
                        (rg.im.main[4, ] - rg.im.main[3, ]),
                        (rg.im.main[5, ] - rg.im.main[4, ]) / 2,
                        (rg.im.main[6, ] - rg.im.main[5, ]) / 2,
                        (rg.im.main[8, ] - rg.im.main[7, ]) / 10,
                        (rg.im.main[9, ] - rg.im.main[8, ]) / 10,
                        (rg.im.main[10, ] - rg.im.main[9, ]) / 10,
                        (rg.im.main[11, ] - rg.im.main[10, ]) / 20,
                        (rg.im.main[12, ] - rg.im.main[11, ]) / 20)
# AM
dif.rg.am.main = rbind((rg.am.main[2, ] - rg.am.main[1, ]),
                        (rg.am.main[3, ] - rg.am.main[2, ]),
                        (rg.am.main[4, ] - rg.am.main[3, ]),
                        (rg.am.main[5, ] - rg.am.main[4, ]) / 2,
                        (rg.am.main[6, ] - rg.am.main[5, ]) / 2,
                        (rg.am.main[8, ] - rg.am.main[7, ]) / 10,
                        (rg.am.main[9, ] - rg.am.main[8, ]) / 10,
                        (rg.am.main[10, ] - rg.am.main[9, ]) / 10,
                        (rg.am.main[11, ] - rg.am.main[10, ]) / 20,
                        (rg.am.main[12, ] - rg.am.main[11, ]) / 20)

####### Results #######

# Compile in dataframes
rg.mode1.1 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[1, ]) / 1,
                                                 (am.rg - rg.am.mode.1[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.mode1.2 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[2, ]) / 2,
                                                 (am.rg - rg.am.mode.1[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.mode1.3 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[3, ]) / 3,
                                                 (am.rg - rg.am.mode.1[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.mode1.4 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[4, ]) / 4,
                                                 (am.rg - rg.am.mode.1[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.mode1.6 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[5, ]) / 5,
                                                 (am.rg - rg.am.mode.1[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.mode1.8 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.1[6, ]) / 6,
                                                 (am.rg - rg.am.mode.1[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

rg.mode2.1 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[1, ]) / 1,
                                                  (am.rg - rg.am.mode.2[1, ]) / 1)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
rg.mode2.2 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[2, ]) / 2,
                                                  (am.rg - rg.am.mode.2[2, ]) / 2)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
rg.mode2.3 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[3, ]) / 3,
                                                  (am.rg - rg.am.mode.2[3, ]) / 3)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
rg.mode2.4 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[4, ]) / 4,
                                                  (am.rg - rg.am.mode.2[4, ]) / 4)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
rg.mode2.6 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[5, ]) / 5,
                                                  (am.rg - rg.am.mode.2[5, ]) / 5)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))
rg.mode2.8 = data.frame(Value = simplify2array(c((im.rg - rg.im.mode.2[6, ]) / 6,
                                                  (am.rg - rg.am.mode.2[6, ]) / 6)),
                         Conformer = c(rep("Inactive", length(im.list$V1)),
                                       rep("Active", length(am.list$V1))))

rg.svd1.1 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.1[1, ]) / 1,
                                                 (am.rg - rg.am.svd.1[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd1.2 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.1[2, ]) / 2,
                                                 (am.rg - rg.am.svd.1[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd1.3 = data.frame(Value = abs(simplify2array(c((im.rg - rg.im.svd.1[3, ]) / 3,
                                                 (am.rg - rg.am.svd.1[3, ]) / 3))),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd1.4 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.1[4, ]) / 4,
                                                 (am.rg - rg.am.svd.1[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd1.6 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.1[5, ]) / 5,
                                                 (am.rg - rg.am.svd.1[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd1.8 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.1[6, ]) / 6,
                                                 (am.rg - rg.am.svd.1[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

rg.svd2.1 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.2[1, ]) / 1,
                                                 (am.rg - rg.am.svd.2[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd2.2 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.2[2, ]) / 2,
                                                 (am.rg - rg.am.svd.2[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd2.3 = data.frame(Value = abs(simplify2array(c((im.rg - rg.im.svd.2[3, ]) / 3,
                                                 (am.rg - rg.am.svd.2[3, ]) / 3))),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd2.4 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.2[4, ]) / 4,
                                                 (am.rg - rg.am.svd.2[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd2.6 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.2[5, ]) / 5,
                                                 (am.rg - rg.am.svd.2[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.svd2.8 = data.frame(Value = simplify2array(c((im.rg - rg.im.svd.2[6, ]) / 6,
                                                 (am.rg - rg.am.svd.2[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

rg.main.1 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[1, ]) / 1,
                                                 (am.rg - rg.am.main[1, ]) / 1)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.main.2 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[2, ]) / 2,
                                                 (am.rg - rg.am.main[2, ]) / 2)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.main.3 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[3, ]) / 3,
                                                 (am.rg - rg.am.main[3, ]) / 3)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.main.4 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[4, ]) / 4,
                                                 (am.rg - rg.am.main[4, ]) / 4)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.main.6 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[5, ]) / 5,
                                                 (am.rg - rg.am.main[5, ]) / 5)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))
rg.main.8 = data.frame(Value = simplify2array(c((im.rg - rg.im.main[6, ]) / 6,
                                                 (am.rg - rg.am.main[6, ]) / 6)),
                        Conformer = c(rep("Inactive", length(im.list$V1)),
                                      rep("Active", length(am.list$V1))))

# Now plot it!
pdf("rg_mode_1.pdf", height = 8, width = 15)
ggplot(rg.mode1.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 1")
ggplot(rg.mode1.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 2")
ggplot(rg.mode1.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 3")
ggplot(rg.mode1.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  ggtitle("Mode 1, displacement 4")
ggplot(rg.mode1.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) + 
  labs(title = "Mode 1, displacement 6")
ggplot(rg.mode1.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
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
pdf("rg_mode_2.pdf", height = 8, width = 15)
ggplot(rg.mode2.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 1")
ggplot(rg.mode2.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 2")
ggplot(rg.mode2.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 3")
ggplot(rg.mode2.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode 1, displacement 4")
ggplot(rg.mode2.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "Mode 1, displacement 6")
ggplot(rg.mode2.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
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

### SVD

pdf("rg_svd_1.pdf", height = 8, width = 15)
ggplot(rg.svd1.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 1, displacement 1")
ggplot(rg.svd1.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 1, displacement 2")
ggplot(rg.svd1.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 1, displacement 3")
ggplot(rg.svd1.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 1, displacement 4")
ggplot(rg.svd1.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "SVD 1, displacement 6")
ggplot(rg.svd1.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 1, displacement 8")
dev.off()
#
pdf("rg_svd_2.pdf", height = 8, width = 15)
ggplot(rg.svd2.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 2, displacement 1")
ggplot(rg.svd2.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 2, displacement 2")
ggplot(rg.svd2.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 2, displacement 3")
ggplot(rg.svd2.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 2, displacement 4")
ggplot(rg.svd2.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  labs(title = "SVD 2, displacement 6")
ggplot(rg.svd2.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("SVD 2, displacement 8")
dev.off()
#
pdf("rg_main.pdf", height = 8, width = 15)
ggplot(rg.main.1, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 1")
ggplot(rg.main.2, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 2")
ggplot(rg.main.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 3")
ggplot(rg.main.4, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 4")
ggplot(rg.main.6, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11])) +
  theme(panel.background =element_blank(),
        title = element_text(size=40),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm")) +
  ggtitle("Mode main, displacement 6")
ggplot(rg.main.8, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
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
matrix(c(mean(simplify2array(im.rg - rg.im.mode.1[3, ])),
mean(simplify2array(im.rg - rg.im.mode.2[3, ])),
mean(simplify2array(im.rg - rg.im.main[3, ])),
mean(simplify2array(im.rg - rg.im.svd.1[3, ])),
mean(simplify2array(im.rg - rg.im.svd.2[3, ])),
# AM
mean(simplify2array(am.rg - rg.am.mode.1[3, ])),
mean(simplify2array(am.rg - rg.am.mode.2[3, ])),
mean(simplify2array(am.rg - rg.am.main[3, ])),
mean(simplify2array(am.rg - rg.am.svd.1[3, ])),
mean(simplify2array(am.rg - rg.am.svd.2[3, ]))), ncol = 2) / 3

# Ahora hago los plots p/ publicación
# SVD 1
plot_1 <- ggplot(rg.svd1.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11]),
                    guide = FALSE) +
  scale_x_continuous(expand = c(0.00, 0.0), breaks = seq(0.001,0.012,0.002),
                     limits = c(0, 0.012)) + 
  scale_y_continuous(expand = c(0.00, 0.0), limits = c(0, 700)) +
  theme(panel.background =element_blank(),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm"),
        axis.line.x = element_line(color="black", size = 0.7),
        axis.line.y = element_line(color="black", size = 0.7)) +
  annotate("text", x= .0115, y = 670, label = "(a)", size = 16) +
  labs(x=expression(paste(Delta, R[g])))

# SVD 2
plot_2 <- ggplot(rg.svd2.3, aes(Value, fill = Conformer)) + geom_density(alpha = .7) +
  scale_fill_manual(values = c(colores.imam[1], colores.imam[11]),
                    guide = guide_legend(title = "")) +
  scale_x_continuous(expand = c(0.00, 0.0), breaks = seq(0.001,0.012,0.002),
                     limits = c(0, 0.012)) + 
  scale_y_continuous(expand = c(0.00, 0.0), limits = c(0, 700)) +
  theme(panel.background =element_blank(),
        axis.text=element_text(size=40),
        axis.title=element_text(size=42),
        legend.text=element_text(size=42),
        legend.title=element_text(size=42),
        legend.position = c(0.91, 0.75),
        plot.margin=unit(c(1, 0, 0.4, 1), "cm"),
        axis.line.x = element_line(color="black", size = 0.7),
        axis.line.y = element_line(color="black", size = 0.7)) +
  annotate("text", x= .0115, y = 670, label = "(b)", size = 16) +
  labs(x=expression(paste(Delta, R[g])))
#
gr1 <- arrangeGrob(plot_1, plot_2, ncol = 2)
ggsave("9-fig_rg_svd.jpeg", gr1, width = 32, height = 8, units = 'in', dpi = 600, quality = 100)
