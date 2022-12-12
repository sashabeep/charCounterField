/**
 * charCounterField
 *
 * Count and indicate minimum and maximum length for admin fields
 *
 * @author      Sasha Beep
 * @category    plugin
 * @version     0.1
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnDocFormRender
 * @internal    @properties &elements=Elements;text;pagetitle,10,70|description,70,160;pagetitle,10,70|description,70,160;id,min,max|...
 * @internal    @installset base, sample
 * @internal    @modx_category Manager and Admin 
 */
if($modx->event->name == 'OnDocFormRender') {
	$elements = explode("|",trim($params['elements']));
	$output = '<script>';
	$output.='$(function(){
	function testLength(elem,min,max){
				var $l = elem[0].value.length;
				console.log($l);
				if($l>min && $l<max){
					elem[0].style.borderColor="green";
					elem[0].style.outline="none";
				}else{
					elem[0].style.borderColor="red";
					elem[0].style.outline="none";
				}
	}';
	
	foreach($elements as $k=>$elem){
		$currEl = explode(",",$elem);
		$el = $currEl[0];
		$min = intval($currEl[1]) > 1 ? intval($currEl[1]) : 1;
		$max = intval($currEl[2]) > 1 ? intval($currEl[2]) : 255;
		$output.='testLength($("[name=\''.$el.'\']"),'.$min.','.$max.');';
		$output.='$("[name=\''.$el.'\']").on("input focus blur change keyup keydown", function(){
				testLength($(this),'.$min.','.$max.');});';
	}
		
	$output.='});';
	$output.= '</script>';
	$modx->event->output($output);
}