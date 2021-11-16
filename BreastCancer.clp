;================================================================
; Author: Fabian Savero Diaz P, Steven Nataniel, Rafi Raihansyah M
; File: BreastCancer.clp
; Description: Decision Tree untuk memprediksi terkena kanker payudara
; atau tidak.
; ===============================================================


(deffacts cancer
  ; NOT CANCER
  (notcancer XRR)       ; Level 2
  (notcancer XLLRR)     ; Level 4
  (notcancer XLRRL)     ; Level 4
  (notcancer XRLLR)     ; Level 4
  (notcancer XRLRR)     ; Level 4
  (notcancer XRLRLL)    ; Level 5
  (notcancer XLLLRRLL)  ; Level boss

  ; CANCER
  (cancer XLRL)         ; Level 3
  (cancer XLLLL)        ; Level 4
  (cancer XLLRL)        ; Level 4
  (cancer XLRRR)        ; Level 4
  (cancer XRLLL)        ; Level 4
  (cancer XLLLRL)       ; Level 5
  (cancer XRLRLR)       ; Level 5
  (cancer XLLLRRR)      ; Level 6
  (cancer XLLLRRLR)     ; Level boss
)

;===========================================
; 
; Level 0
; 
;===========================================
(defrule ask_mean_concave_L0
=>
  (printout t "Mean Concave Points: ")
  (bind ?x (read))
  (if (<= ?x 0.05)
		then (assert (phase XL))
  else (if (> ?x 0.05)
		then (assert (phase XR))
	)
))

;===========================================
; 
; Level 1
; 
;===========================================
(defrule ask_worst_radius_L1
  ?phase <- (phase XL)
=>
  (retract ?phase)
  (printout t "Worst Radius: ")
  (bind ?x (read))
  (if (<= ?x 16.83)
    then (assert (phase XLL))
    else (assert (phase XLR))
  )
)

(defrule ask_worst_perimeter_L1
  ?phase <- (phase XR)
=>
  (retract ?phase)
  (printout t "Worst Perimeter: ")
  (bind ?x (read))
  (if (<= ?x 114.45)
    then (assert (phase XRL))
    else (assert (phase XRR))
  )
)

;===========================================
; 
; Level 2
; 
;===========================================

(defrule ask_radius_error_L2
  ?phase <- (phase XLL)
=>
  (retract ?phase)
  (printout t "Radius Error: ")
  (bind ?x (read))
  (if (<= ?x 0.63)
    then (assert (phase XLLL))
    else (assert (phase XLLR))
  )
)

(defrule ask_mean_texture_L2
  ?phase <- (phase XLR)
=>
  (retract ?phase)
  (printout t "Mean Texture: ")
  (bind ?x (read))
  (if (<= ?x 16.19)
    then (assert (phase XLRL))
    else (assert (phase XLRR))
  )
)

(defrule ask_worst_texture_L2
  ?phase <- (phase XRL)
=>
  (retract ?phase)
  (printout t "Worst Texture: ")
  (bind ?x (read))
  (if (<= ?x 25.65)
    then (assert (phase XRLL))
    else (assert (phase XRLR))
  )
)

;===========================================
; 
; Level 3
; 
;===========================================

(defrule ask_worst_texture_L3
  ?phase <- (phase XLLL)
=>
  (retract ?phase)
  (printout t "Worst Texture: ")
  (bind ?x (read))
  (if (<= ?x 30.15)
    then (assert (phase XLLLL))
    else (assert (phase XLLLR))
  )
)

(defrule ask_mean_smoothness_L3
  ?phase <- (phase XLLR)
=>
  (retract ?phase)
  (printout t "Mean Smoothness: ")
  (bind ?x (read))
  (if (<= ?x 0.09)
    then (assert (phase XLLRL))
    else (assert (phase XLLRR))
  )
)

(defrule ask_concave_points_error_L3
  ?phase <- (phase XLRR)
=>
  (retract ?phase)
  (printout t "Concave Points Error: ")
  (bind ?x (read))
  (if (<= ?x 0.01)
    then (assert (phase XLRRL))
    else (assert (phase XLRRR))
  )
)

(defrule ask_worst_concave_points_L3
  ?phase <- (phase XRLL)
=>
  (retract ?phase)
  (printout t "Worst Concave Points: ")
  (bind ?x (read))
  (if (<= ?x 0.17)
    then (assert (phase XRLLL))
    else (assert (phase XRLLR))
  )
)

(defrule ask_perimeter_error_L3
  ?phase <- (phase XRLR)
=>
  (retract ?phase)
  (printout t "Perimeter Error: ")
  (bind ?x (read))
  (if (<= ?x 1.56)
    then (assert (phase XRLRL))
    else (assert (phase XRLRR))
  )
)

;===========================================
; 
; Level 4
; 
;===========================================

(defrule ask_worst_area_L4
  ?phase <- (phase XLLLR)
=>
  (retract ?phase)
  (printout t "Worst Area: ")
  (bind ?x (read))
  (if (<= ?x 641.6)
    then (assert (phase XLLLRL))
    else (assert (phase XLLLRR))
  )
)

(defrule ask_mean_radius_L4
  ?phase <- (phase XRLRL)
=>
  (retract ?phase)
  (printout t "Mean Radius: ")
  (bind ?x (read))
  (if (<= ?x 13.34)
    then (assert (phase XRLRLL))
    else (assert (phase XRLRLR))
  )
)

;===========================================
; 
; Level 5
; 
;===========================================

(defrule ask_mean_radius_L5
  ?phase <- (phase XLLLRR)
=>
  (retract ?phase)
  (printout t "Mean Radius: ")
  (bind ?x (read))
  (if (<= ?x 13.45)
    then (assert (phase XLLLRRL))
    else (assert (phase XLLLRRR))
  )
)

;===========================================
; 
; Level 6
; 
;===========================================

(defrule ask_mean_texture_L6
  ?phase <- (phase XLLLRRL)
=>
  (retract ?phase)
  (printout t "Mean Texture: ")
  (bind ?x (read))
  (if (<= ?x 28.79)
    then (assert (phase XLLLRRLL))
    else (assert (phase XLLLRRLR))
  )
)

;===========================================
; 
; Result
; 
;===========================================
(defrule check_final_cancer
    (and (cancer ?phase) (phase ?phase))
=>
    (printout t "Selamat anda mendapatkan hasil positif!" crlf)
)

(defrule check_final_notcancer
    (and (notcancer ?phase) (phase ?phase))
=>
    (printout t "Yah, ga kanker, ga seru. :(" crlf)
)
