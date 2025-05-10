shader_type canvas_item;

void vertex(){

}

void fragment() {

    COLOR = vec4(0.0, 0.0, 0.0,texture(TEXTURE, UV).a/2.0);
}
