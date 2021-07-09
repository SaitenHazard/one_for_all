GDPC                                                                            '   @   res://.import/bullet.png-1227a1f8ee335c2507e15c2db3268153.stex  �Y      |       �([��3��,c.��0D   res://.import/bullet_enemy.png-1e6b408c75ea1cf4b3a08a8b7ce23b41.stex�\      |       [z�3�5�`!OԒ�@   res://.import/enemy.png-badd7452294bc3a16746ecd90b619b9c.stex   `      �       �g�fy�����p *�@   res://.import/hearts.png-fca223a40714a689f926d93ad1b71cbe.stex  0c      �       �g�fy�����p *�<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex J      U      -��`�0��x�5�[@   res://.import/player.png-fbd6493f73cbaa7a64d889bdaf878116.stex  Pf      �        ����6���Wo<   res://.import/shot.png-f483bc563c7d72ca600550cd5b88f7ae.stexpi      �       �="!�H<�nh��D�<   res://.import/tile.png-126495713c413490c51904665db8e3aa.stex�l      �       v�n�Q�o&��F   res://Scenes/Bullet.tscn0      �      z�19�$a�ZW���Ku   res://Scenes/Enemy.tscn        �      �d�0U�(�^?>�;    res://Scenes/Enemy_bullet.tscn  �      �      �?��V#Q��8-I#df   res://Scenes/MainScene.tscn �      �      ��=/�������5)��   res://Scenes/Pickup.tscn@#      �      �1k��Gy�A.���C   res://Scenes/Player.tscn@%      �      �d���lC���1   res://Scenes/Tile.tscn  @(      �      �����	�z�3]A�   res://Scenes/UIShots.tscn   �)      +      D�A`���J���    res://Scripts/Bullet.gd.remap   �o      )       0L��K���#�ѐ�3�   res://Scripts/Bullet.gdc ,      �       �3ֹ��9pE|�-�;   res://Scripts/Enemy.gd.remap�o      (       �w7P�1��ɇ�8��   res://Scripts/Enemy.gdc �,            �Z��XL8��#�V�$   res://Scripts/Enemy_bullet.gd.remap  p      /       ��	N�%�L*��:�*�    res://Scripts/Enemy_bullet.gdc  �1      R      `us��pA_�X��}�3    res://Scripts/Pickup.gd.remap   Pp      )       �x?���l�NU�/K�   res://Scripts/Pickup.gdc 3      �       Q��2�� �����+�    res://Scripts/Player.gd.remap   �p      )       <y;�9Y;�k��S�   res://Scripts/Player.gdc 4      �      C��i"�J�j��e���{    res://Scripts/UIShots.gd.remap  �p      *       ��u��W��$�@j�   res://Scripts/UIShots.gdc    G      /      ����0%Q;��p�   res://default_env.tres  PI      �       um�`�N��<*ỳ�8   res://icon.png  �p      �      G1?��z�c��vN��   res://icon.png.import   `W      �      �����%��(#AB�   res://project.binary�}      G      �H6�0���%�U���    res://sprite/bullet.png.import  `Z      �      E���82yу��V&mr�$   res://sprite/bullet_enemy.png.importp]      �      2���d��e�~4���#    res://sprite/enemy.png.import   �`      �      1"����;!�+וv    res://sprite/hearts.png.import  �c      �      ���ʀ���&����    res://sprite/player.png.import  �f      �      R�a�*�o+#n{���   res://sprite/shot.png.import j      �      �U$엇�� �\|�'?   res://sprite/tile.png.import0m      �      s
�
ٓ�΢���jB�&        [gd_scene load_steps=5 format=2]

[ext_resource path="res://sprite/bullet.png" type="Texture" id=1]
[ext_resource path="res://Scripts/Bullet.gd" type="Script" id=2]

[sub_resource type="PhysicsMaterial" id=1]

[sub_resource type="CircleShape2D" id=2]
radius = 4.96692

[node name="Bullet" type="RigidBody2D" groups=[
"bullet",
]]
physics_material_override = SubResource( 1 )
script = ExtResource( 2 )

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource( 2 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="Lifetime" type="Timer" parent="."]
wait_time = 2.0
one_shot = true
autostart = true
[connection signal="timeout" from="Lifetime" to="." method="_on_Lifetime_timeout"]
     [gd_scene load_steps=4 format=2]

[ext_resource path="res://Scripts/Enemy.gd" type="Script" id=1]
[ext_resource path="res://sprite/enemy.png" type="Texture" id=2]

[sub_resource type="CircleShape2D" id=1]
radius = 9.55653

[node name="Enemy" type="Area2D"]
script = ExtResource( 1 )

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
scale = Vector2( 3, 3 )
shape = SubResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
scale = Vector2( 3, 3 )
texture = ExtResource( 2 )

[node name="Cooldown" type="Timer" parent="."]
one_shot = true
[connection signal="body_entered" from="." to="." method="_on_Area2D_body_entered"]
           [gd_scene load_steps=5 format=2]

[ext_resource path="res://sprite/bullet_enemy.png" type="Texture" id=1]
[ext_resource path="res://Scripts/Enemy_bullet.gd" type="Script" id=2]

[sub_resource type="PhysicsMaterial" id=2]

[sub_resource type="CircleShape2D" id=1]
radius = 4.91045

[node name="Enemy_bullet" type="RigidBody2D" groups=[
"enemy_bullet",
]]
physics_material_override = SubResource( 2 )
script = ExtResource( 2 )

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )
one_way_collision_margin = 12.2

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="Lifetime" type="Timer" parent="."]
wait_time = 2.0
one_shot = true
autostart = true
[connection signal="body_entered" from="." to="." method="_on_Enemy_bullet_body_entered"]
[connection signal="body_exited" from="." to="." method="_on_Enemy_bullet_body_exited"]
[connection signal="timeout" from="Lifetime" to="." method="_on_Lifetime_timeout"]
           [gd_scene load_steps=7 format=2]

[ext_resource path="res://Scenes/Player.tscn" type="PackedScene" id=1]
[ext_resource path="res://Scenes/Tile.tscn" type="PackedScene" id=2]
[ext_resource path="res://Scenes/UIShots.tscn" type="PackedScene" id=3]
[ext_resource path="res://Scenes/Pickup.tscn" type="PackedScene" id=4]
[ext_resource path="res://Scenes/Enemy.tscn" type="PackedScene" id=5]

[sub_resource type="PhysicsMaterial" id=1]
friction = 0.5

[node name="MainScene" type="Node2D"]
position = Vector2( 0, -23.7841 )

[node name="Tile5" parent="." instance=ExtResource( 2 )]
position = Vector2( 316.54, 322.976 )
scale = Vector2( 4.72001, 1 )

[node name="Tile6" parent="." instance=ExtResource( 2 )]
position = Vector2( 722.289, 259.408 )
scale = Vector2( 13.0725, 1 )

[node name="Tile7" parent="." instance=ExtResource( 2 )]
position = Vector2( 1054.13, 56 )
scale = Vector2( 6.43253, 1 )

[node name="Tile8" parent="." instance=ExtResource( 2 )]
position = Vector2( 513.129, -229.088 )
scale = Vector2( 6.43253, 1 )

[node name="Tile10" parent="." instance=ExtResource( 2 )]
position = Vector2( 258.688, -341.356 )
scale = Vector2( 2.75253, 1 )

[node name="Tile11" parent="." instance=ExtResource( 2 )]
position = Vector2( 0, -357.356 )
scale = Vector2( 2.75253, 1 )

[node name="Tile12" parent="." instance=ExtResource( 2 )]
position = Vector2( -189.417, -357.356 )
scale = Vector2( 2.75253, 1 )

[node name="Tile13" parent="." instance=ExtResource( 2 )]
position = Vector2( -397.512, -357.356 )
scale = Vector2( 2.75253, 1 )

[node name="Tile9" parent="." instance=ExtResource( 2 )]
position = Vector2( -31.6957, -229.088 )
scale = Vector2( 21.8334, 1 )

[node name="Enemy" parent="." instance=ExtResource( 5 )]
position = Vector2( -35.1024, -269.16 )

[node name="Player" parent="." instance=ExtResource( 1 )]
position = Vector2( 332.54, 177.404 )
mode = 2
physics_material_override = SubResource( 1 )
gravity_scale = 8.5

[node name="Camera2D" type="Camera2D" parent="Player"]
current = true

[node name="CanvasLayer" type="CanvasLayer" parent="Player/Camera2D"]

[node name="Shots" parent="Player/Camera2D/CanvasLayer" instance=ExtResource( 3 )]

[node name="Pickup" parent="." instance=ExtResource( 4 )]
position = Vector2( 851.518, 111.925 )

[node name="Pickup2" parent="." instance=ExtResource( 4 )]
position = Vector2( 1072.21, 20 )

[node name="Pickup3" parent="." instance=ExtResource( 4 )]
position = Vector2( 1122.54, 24 )

[node name="Pickup4" parent="." instance=ExtResource( 4 )]
position = Vector2( 410.208, -277.16 )

[node name="Pickup5" parent="." instance=ExtResource( 4 )]
position = Vector2( 268.101, -273.16 )

[node name="Pickup6" parent="." instance=ExtResource( 4 )]
position = Vector2( 210.647, -269.16 )

[node name="Pickup7" parent="." instance=ExtResource( 4 )]
position = Vector2( -233.457, -269.16 )

[node name="Pickup8" parent="." instance=ExtResource( 4 )]
position = Vector2( -313.201, -269.16 )

[node name="Pickup9" parent="." instance=ExtResource( 4 )]
position = Vector2( -418.082, -391.916 )

[node name="Pickup10" parent="." instance=ExtResource( 4 )]
position = Vector2( -381.03, -391.916 )

[node name="Pickup11" parent="." instance=ExtResource( 4 )]
position = Vector2( -213.565, -391.916 )

[node name="Pickup12" parent="." instance=ExtResource( 4 )]
position = Vector2( -161.03, -383.916 )

[node name="Pickup13" parent="." instance=ExtResource( 4 )]
position = Vector2( -27.6957, -387.916 )

[node name="Pickup14" parent="." instance=ExtResource( 4 )]
position = Vector2( 20, -387.916 )

[node name="Pickup15" parent="." instance=ExtResource( 4 )]
position = Vector2( 241.02, -373.356 )

[node name="Pickup16" parent="." instance=ExtResource( 4 )]
position = Vector2( 272.101, -369.356 )
               [gd_scene load_steps=4 format=2]

[ext_resource path="res://sprite/bullet.png" type="Texture" id=1]
[ext_resource path="res://Scripts/Pickup.gd" type="Script" id=2]

[sub_resource type="CircleShape2D" id=1]

[node name="Pickup" type="Area2D"]
script = ExtResource( 2 )

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 1 )
[connection signal="body_entered" from="." to="." method="body_entered"]
    [gd_scene load_steps=5 format=2]

[ext_resource path="res://Scripts/Player.gd" type="Script" id=1]
[ext_resource path="res://sprite/player.png" type="Texture" id=2]

[sub_resource type="PhysicsMaterial" id=1]

[sub_resource type="CircleShape2D" id=2]
radius = 9.58751

[node name="Player" type="RigidBody2D"]
physics_material_override = SubResource( 1 )
custom_integrator = true
contacts_reported = 3
contact_monitor = true
script = ExtResource( 1 )

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource( 2 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 2 )

[node name="Cooldown" type="Timer" parent="."]
one_shot = true
[connection signal="body_entered" from="." to="." method="_on_Player_body_entered"]
    [gd_scene load_steps=3 format=2]

[ext_resource path="res://sprite/tile.png" type="Texture" id=1]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 16.1326, 14.2205 )

[node name="Tile" type="StaticBody2D"]

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 1 )
             [gd_scene load_steps=3 format=2]

[ext_resource path="res://sprite/shot.png" type="Texture" id=1]
[ext_resource path="res://Scripts/UIShots.gd" type="Script" id=2]

[node name="UIShots" type="Control"]
margin_left = 20.0
margin_top = 20.0
margin_right = 40.0
margin_bottom = 40.0
script = ExtResource( 2 )
__meta__ = {
"_edit_use_anchors_": false
}

[node name="Shots" type="TextureRect" parent="."]
margin_right = 8.0
margin_bottom = 8.0
rect_scale = Vector2( 2, 2 )
texture = ExtResource( 1 )
stretch_mode = 2
__meta__ = {
"_edit_use_anchors_": false
}
     GDSC                   ��������τ�   �������������������¶���   ���������Ӷ�                   	            3YY0�  PQV�  T�  PQY`          GDSC         '   �      ���ׄ�   �������Ѷ���   �����������¶���   �����¶�   �������Ӷ���   ��������¶��   �����϶�   �������¶���   �������Ӷ���   �����������Ķ���   �������۶���   �������Ӷ���   ��Ŷ   �������ض���   ���������¶�   ��������Ҷ��   ������������ض��   ���������Ҷ�   ����������������   ��������������϶   �������ׄ�������������Ҷ   ���϶���   ����������ƶ   ���������Ӷ�             res://Scenes/Enemy_bullet.tscn        /root/MainScene/Player                     @      timeout      HD      bullet                                                   !      "      )   	   *   
   0      4      5      6      7      8      >      B      P      Q      Z      a      b      h      q      r      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   3YYY;�  V�  Y5;�  V�  ?P�  QY5;�  V�  �  P�  QYY;�  V�  �  YY0�  PQV�  �  PQ�  YY�  Y0�  PQV�  *�  V�  AP�  PQT�	  P�  QR�  Q�  �  ;�
  �  T�  PQ�  ;�  T�  �  �  �
  T�  �  �  �  PQT�  P�
  Q�  �  ;�  P�  T�  T�  QT�  PQ�  ;�  �  �  �  �
  T�  �  �  YYY0�  P�  QV�  &�  T�  P�  QV�  �  T�  PQ�  �  �  �	  �  �  &�  �
  V�  T�  PQY`   GDSC         
   ,      ��������τ�    ����������������������������Ҷ��   ���϶���   ���Ӷ���   ���������Ӷ�   �������������������¶���      in        Player                     
                              $   	   *   
   3YY0�  P�  QV�  �?  PQ�  &�  T�  �  V�  �  T�  PQYY0�  PQV�  T�  PQY`              GDSC                   ���ׄ�   �����������Ҷ���   ���϶���   ���Ӷ���   ������������������Ҷ   ���������Ӷ�      Player                     
                        3YY0�  P�  QV�  &�  T�  V�  �  T�  PQ�  T�  PQY`  GDSC   L      �   R     ��������τ�   ��������嶶�   �����������������䶶   ������������   ����������������   ����������������ﶶ�   ������������   ������������   ������������ﶶ�   �����������������������   ����������������   ������������   ��������������Ŷ   ������������ض��   ���������������������ض�   ������������Ӷ��   ����������ض   ��������¶��   ���������¶�   ����¶��   ���������Ӷ�   ���ƶ���   �������Ķ���   ������������������Ķ   �������ض���   ����Ķ��   �����¶�   ������������Ŷ��   ������������������Ŷ   �������Ŷ���   ����׶��   �����������������ض�   ������������ض��   ���������Ҷ�   ������������������������ض��   ��������������ض   ���������Ҷ�   ����������������Ŷ��   ��������������Ӷ   ���������¶�   ��������¶��   ����������Ķ   ��������Ķ��   ������������϶��   ����������Ķ   ������������������϶   �������ƶ���   ����������������϶��   ������������������϶   �������۶���   �������Ӷ���   ��Ŷ   �������ض���   ���������¶�   ��������Ҷ��   ��������������϶    ���������������������������޶���   ����¶��   ����������������Ҷ��   ����¶��   ����������Ķ   ����������ζ   ζ��   ����������������¶��   �������������ڶ�   �����������������������ڶ���   ��¶   ����   ϶��   �����������������������Ӷ���   ������������������Ҷ   ����������������������Ҷ   ���϶���   ���Ӷ���   ����������ƶ   ���������Ӷ�           zD     /D     HD     D  333333�?      ?  @��x�D      res://Scenes/Bullet.tscn   	   move_left      
   move_right        shoot                   333333�?                   enemy_bullet                   
                        &      -   	   4   
   ;      B      I      P      Q      X      Y      ^      c      h      m      r      w      |      }      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1     2     3   
  4     5     6     7     8      9   $  :   (  ;   ,  <   -  =   3  >   ;  ?   E  @   F  A   L  B   R  C   \  D   c  E   d  F   j  G   o  H   q  I   r  J   {  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^   �  _   �  `   �  a   �  b   	  c     d     e   "  f   #  g   '  h   3  i   7  j   ;  k   >  l   B  m   C  n   I  o   M  p   T  q   ]  r   e  s   l  t   t  u   |  v     w   �  x   �  y   �  z   �  {   �  |   �  }   �  ~   �     �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �     �     �     �     �   %  �   &  �   ,  �   2  �   3  �   :  �   A  �   J  �   P  �   3YY:�  V�  Y:�  V�  Y:�  V�  �  Y:�  V�  �  Y:�  V�  �  Y:�  V�  �  Y:�  V�  �  Y:�  V�  �  Y:�	  V�  �  Y:�
  V�  �  Y:�  V�  �  YY;�  V�  �  YY;�  V�  Y;�  V�  Y;�  �  Y;�  V�  Y;�  V�  Y;�  V�  Y;�  V�  YY;�  Y;�  V�  Y;�  V�  Y;�  V�  YY5;�  V�  W�  Y;�  V�  ?P�  QYY0�  PQX�  V�  .�  �  Y0�  PQX�  V�  .�  YY0�  P�  QV�  �  PQ�  �   PQ�  Y0�   PQV�  �  �  T�!  PQ�  Y0�  PQV�  ;�  P�"  PQT�#  QT�$  PQ�  T�  �  �  T�  �  YY0�%  P�  QV�  T�  �  �  �&  PQ�  �'  PQ�  �(  PQ�  �)  PQ�  �*  PQ�  �+  PQ�  �,  PQYY0�&  PQV�  �  �  T�-  PQ�  T�  �  T�.  PQ�  Y0�+  PQV�  �  �  	�	  �  �  �  T�/  PQ�  �  �  T�0  P�  Q�  Y0�(  PQV�  &�  V�  .�  �  ;�1  �  T�2  PQ�  ;�3  T�4  �  �  �1  T�4  �3  �  �5  PQT�6  P�1  QY�  �1  T�7  �  �
  �  �8  P�1  QYY0�'  PQV�  �  �9  T�:  P�	  Q�  �  �9  T�:  P�
  Q�  �  �9  T�:  P�  Q�  �  �  �  �  &�  V�  �  �  �  �  �  �  �  T�;  P�  Q�  Y0�,  PQV�  ;�<  �  �  ;�=  Y�  )�>  �K  P�  T�?  PQQV�  ;�@  �  T�A  P�>  Q�  &�@  T�B  P�  P�  RQQ�  V�  �<  �  �  �=  �>  Y�  &�<  V�  &�  �  �  T�>  �  V�  �  �  �  �  �  �  (V�  �  �  �  Y0�)  PQV�  &�  V�  &�  �  V�  &�  T�>  �  V�  �  T�>  �  �  �  '�  �  V�  &�  T�>  	�  V�  �  T�>  �  �  �  (V�  ;�C  �  P�  T�>  Q�  �C  �  �  �  &�C  	�  V�  �C  �  �  �  T�>  �  P�  T�>  Q�C  �  Y0�*  PQV�  &�  V�  �  T�D  �  �  T�D  �  �  T�>  �  �  T�>  �  �  &�  V�  &�  �  V�  &�  T�>  �  V�  �  T�>  �  �  �  '�  �  V�  &�  T�>  	�  V�  �  T�>  �  �  �  (V�  ;�E  �  P�  T�>  Q�  �E  �  �  �  �  &�E  	�  V�  �E  �  �  �  T�>  �  P�  T�>  Q�E  YY0�F  PQV�  �  �  YY0�G  P�H  QV�  �?  P�H  T�I  Q�  &�H  T�J  P�  QV�  T�K  PQY`               GDSC            S      ������ڶ   ������������   ��������������Ŷ   ����Ŷ��   �����Ķ�   ����������¶   �������Ŷ���   ����׶��   ������������������Ŷ   ����������Ӷ   ��������Ӷ��   ζ��            Player                                               	                           	   &   
   .      6      =      G      J      Q      3YY:�  YY;�  V�  Y5;�  W�  Y5;�  �  P�  QYY0�  P�  QV�  �  �  T�  PQ�  &P�  �  QV�  �  T�	  P�  Q�  �  T�
  T�  �  �  �  (V�  �  T�	  P�  QY` [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @           9  PNG �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx�ݜytTU��?��WK*�=���%�  F����0N��݂:���Q�v��{�[�����E�ӋH���:���B�� YHB*d_*�jyo�(*M�JR!h��S�T��w�߻���ro���� N�\���D�*]��c����z��D�R�[�
5Jg��9E�|JxF׵'�a���Q���BH�~���!����w�A�b
C1�dB�.-�#��ihn�����u��B��1YSB<%�������dA�����C�$+(�����]�BR���Qsu][`
�DV����у�1�G���j�G͕IY! L1�]��� +FS�IY!IP ��|�}��*A��H��R�tQq����D`TW���p\3���M���,�fQ����d��h�m7r�U��f������.��ik�>O�;��xm��'j�u�(o}�����Q�S�-��cBc��d��rI�Ϛ�$I|]�ơ�vJkZ�9>��f����@EuC�~�2�ym�ش��U�\�KAZ4��b�4������;�X婐����@Hg@���o��W�b�x�)����3]j_��V;K����7�u����;o�������;=|��Ŗ}5��0q�$�!?��9�|�5tv�C�sHPTX@t����w�nw��۝�8�=s�p��I}�DZ-̝�ǆ�'�;=����R�PR�ۥu���u��ǻC�sH`��>�p�P ���O3R�������۝�SZ7 �p��o�P!�
��� �l��ހmT�Ƴێ�gA��gm�j����iG���B� ܦ(��cX�}4ۻB��ao��"����� ����G�7���H���æ;,NW?��[��`�r~��w�kl�d4�������YT7�P��5lF�BEc��=<�����?�:]�������G�Μ�{������n�v��%���7�eoݪ��
�QX¬)�JKb����W�[�G ��P$��k�Y:;�����{���a��&�eפ�����O�5,;����yx�b>=fc�* �z��{�fr��7��p���Ôִ�P����t^�]͑�~zs.�3����4��<IG�w�e��e��ih�/ˆ�9�H��f�?����O��.O��;!��]���x�-$E�a1ɜ�u�+7Ȃ�w�md��5���C.��\��X��1?�Nغ/�� ��~��<:k?8��X���!���[���꩓��g��:��E����>��꩓�u��A���	iI4���^v:�^l/;MC��	iI��TM-$�X�;iLH���;iI1�Zm7����P~��G�&g�|BfqV#�M������%��TM��mB�/�)����f����~3m`��������m�Ȉ�Ƽq!cr�pc�8fd���Mۨkl�}P�Л�汻��3p�̤H�>+���1D��i�aۡz�
������Z�Lz|8��.ִQ��v@�1%&���͏�������m���KH�� �p8H�4�9����/*)�aa��g�r�w��F36���(���7�fw����P��&�c����{﹏E7-f�M�).���9��$F�f r �9'1��s2).��G��{���?,�
�G��p�µ�QU�UO�����>��/�g���,�M��5�ʖ�e˃�d����/�M`�=�y=�����f�ӫQU�k'��E�F�+ =΂���
l�&���%%�������F#KY����O7>��;w���l6***B�g)�#W�/�k2�������TJ�'����=!Q@mKYYYdg��$Ib��E�j6�U�,Z�鼌Uvv6YYYԶ��}( ���ߠ#x~�s,X0�����rY��yz�	|r�6l����cN��5ϑ��KBB���5ϡ#xq�7�`=4A�o�xds)�~wO�z�^��m���n�Ds�������e|�0�u��k�ٱ:��RN��w�/!�^�<�ͣ�K1d�F����:�������ˣ����%U�Ą������l{�y����)<�G�y�`}�t��y!��O@� A� Y��sv:K�J��ՎۣQ�܃��T6y�ǯ�Zi
��<�F��1>�	c#�Ǉ��i�L��D�� �u�awe1�e&')�_�Ǝ^V�i߀4�$G�:��r��>h�hݝ������t;)�� &�@zl�Ұր��V6�T�+����0q��L���[t���N&e��Z��ˆ/����(�i啝'i�R�����?:
P].L��S��E�݅�Á�.a6�WjY$F�9P�«����V^7���1Ȓ� �b6�(����0"�k�;�@MC���N�]7 �)Q|s����QfdI���5 ��.f��#1���G���z���>)�N�>�L0T�ۘ5}��Y[�W뿼mj���n���S?�v��ْ|.FE"=�ߑ��q����������p����3�¬8�T�GZ���4ݪ�0�L�Y��jRH��.X�&�v����#�t��7y_#�[�o��V�O����^�����paV�&J�V+V��QY����f+m��(�?/������{�X��:�!:5�G�x���I����HG�%�/�LZ\8/����yLf�Æ>�X�Єǣq���$E������E�Ǣ�����gێ��s�rxO��x孏Q]n���LH����98�i�0==���O$5��o^����>6�a� �*�)?^Ca��yv&���%�5>�n�bŜL:��y�w���/��o�褨A���y,[|=1�VZ�U>,?͑���w��u5d�#�K�b�D�&�:�����l~�S\���[CrTV�$����y��;#�������6�y��3ݸ5��.�V��K���{�,-ւ� k1aB���x���	LL� ����ңl۱������!U��0L�ϴ��O\t$Yi�D�Dm��]|�m���M�3���bT�
�N_����~uiIc��M�DZI���Wgkn����C��!xSv�Pt�F��kڨ��������OKh��L����Z&ip��
ޅ���U�C�[�6��p���;uW8<n'n��nͽQ�
�gԞ�+Z	���{���G�Ĭ� �t�]�p;躆 ��.�ۣ�������^��n�ut�L �W��+ ���hO��^�w�\i� ��:9>3�=��So�2v���U1z��.�^�ߋěN���,���� �f��V�    IEND�B`�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
GDST               `   PNG �PNG

   IHDR         ���   sRGB ���   IDAT�c����?��Or�(  @�f{:    IEND�B`�    [remap]

importer="texture"
type="StreamTexture"
path="res://.import/bullet.png-1227a1f8ee335c2507e15c2db3268153.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/bullet.png"
dest_files=[ "res://.import/bullet.png-1227a1f8ee335c2507e15c2db3268153.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
  GDST              `   PNG �PNG

   IHDR         ���   sRGB ���   IDAT�c<�w�?��Or�(  �y���E�    IEND�B`�    [remap]

importer="texture"
type="StreamTexture"
path="res://.import/bullet_enemy.png-1e6b408c75ea1cf4b3a08a8b7ce23b41.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/bullet_enemy.png"
dest_files=[ "res://.import/bullet_enemy.png-1e6b408c75ea1cf4b3a08a8b7ce23b41.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
 GDST              g   PNG �PNG

   IHDR         ��a   sRGB ���   IDAT8�c�������D��QF5`0  �O����    IEND�B`�             [remap]

importer="texture"
type="StreamTexture"
path="res://.import/enemy.png-badd7452294bc3a16746ecd90b619b9c.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/enemy.png"
dest_files=[ "res://.import/enemy.png-badd7452294bc3a16746ecd90b619b9c.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
      GDST              g   PNG �PNG

   IHDR         ��a   sRGB ���   IDAT8�c�������D��QF5`0  �O����    IEND�B`�             [remap]

importer="texture"
type="StreamTexture"
path="res://.import/hearts.png-fca223a40714a689f926d93ad1b71cbe.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/hearts.png"
dest_files=[ "res://.import/hearts.png-fca223a40714a689f926d93ad1b71cbe.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
   GDST               g   PNG �PNG

   IHDR         ��a   sRGB ���   IDAT8�c\cd����D��QF5`0  ��/5�_k    IEND�B`�             [remap]

importer="texture"
type="StreamTexture"
path="res://.import/player.png-fbd6493f73cbaa7a64d889bdaf878116.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/player.png"
dest_files=[ "res://.import/player.png-fbd6493f73cbaa7a64d889bdaf878116.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
  GDST               l   PNG �PNG

   IHDR         ���   sRGB ���   "IDAT�c���/`���q�32����0�|��K �F�@�    IEND�B`�        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/shot.png-f483bc563c7d72ca600550cd5b88f7ae.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/shot.png"
dest_files=[ "res://.import/shot.png-f483bc563c7d72ca600550cd5b88f7ae.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
        GDST                 }   PNG �PNG

   IHDR           szz�   sRGB ���   3IDATX���A @���\���&'���@��{sػ�              $�
���>��    IEND�B`�       [remap]

importer="texture"
type="StreamTexture"
path="res://.import/tile.png-126495713c413490c51904665db8e3aa.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprite/tile.png"
dest_files=[ "res://.import/tile.png-126495713c413490c51904665db8e3aa.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
        [remap]

path="res://Scripts/Bullet.gdc"
       [remap]

path="res://Scripts/Enemy.gdc"
        [remap]

path="res://Scripts/Enemy_bullet.gdc"
 [remap]

path="res://Scripts/Pickup.gdc"
       [remap]

path="res://Scripts/Player.gdc"
       [remap]

path="res://Scripts/UIShots.gdc"
      �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG	      _global_script_classes             _global_script_class_icons             application/config/name         One For All    application/run/main_scene$         res://Scenes/MainScene.tscn    application/config/icon         res://icon.png     input/move_right`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      unicode           echo          script         input/move_left`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script         input/shoot�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode          unicode           echo          script      )   rendering/environment/default_environment          res://default_env.tres           