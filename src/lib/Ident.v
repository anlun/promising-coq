Require Import PArith.
Require Import MSetList.
Require Import PeanoNat.

Require Import DataStructure.

Set Implicit Arguments.

Require Import UsualFMapPositive.

Module Ident <: OrderedTypeWithLeibniz.
  Include Pos.

  Lemma eq_leibniz (x y: t): eq x y -> x = y.
  Proof. auto. Qed.

  Parameter of_string: String.string -> t.
  Hypothesis of_string_inject:
    forall s1 s2 (H12: s1 <> s2), of_string s1 <> of_string s2.

  Ltac ltb_tac :=
    match goal with
    | [H: compare ?x1 ?x2 = _ |- _] =>
      generalize (compare_spec x1 x2); rewrite H; clear H;
      intro H; inversion H; subst; clear H
    | [H: lt ?x ?x |- _] =>
      destruct lt_strorder; congruence
    | [H: lt ?x ?y |- _] =>
      rewrite H in *; clear H
    | [H: eq ?x ?y |- _] =>
      rewrite H in *; clear H
    end.

  Lemma eq_dec_eq A i (a1 a2:A):
    (if eq_dec i i then a1 else a2) = a1.
  Proof.
    destruct (eq_dec i i); [|congruence]. auto.
  Qed.

  Lemma eq_dec_neq A i1 i2 (a1 a2:A)
        (NEQ: i1 <> i2):
    (if eq_dec i1 i2 then a1 else a2) = a2.
  Proof.
    destruct (eq_dec i1 i2); [congruence|]. auto.
  Qed.
End Ident.

Module IdentFun := UsualFun (Ident).
Module IdentSet := UsualSet (Ident).
Module IdentMap := UsualPositiveMap.

Module Loc := Ident.
Module LocSet := IdentSet.
Module LocMap := IdentMap.
Module LocFun := IdentFun.


Module Const := Nat.
