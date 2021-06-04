<?php
// Types
$types = array(
		1 => 'Colours',
		2 => 'Fruit'
	);

// Groups
$groups = array();
$groups[1] = array(
		1 => 'Dark',
		2 => 'Light'
	);

$groups[2] = array(
		1 => 'Ripe',
		2 => 'Rotten'
	);

// Items
$items = array();
$items[1][1] = array(
		1 => 'Black',
		2 => 'Brown',
		3 => 'Grey'
	);
$items[1][2] = array(
		1 => 'Red',
		2 => 'Green',
		3 => 'Blue'
	);

$items[2][1] = array(
		1 => 'Banana',
		2 => 'Apple',
		3 => 'Orange'
	);
$items[2][2] = array(
		1 => 'Pear',
		2 => 'Peach',
		3 => 'Mango'
	);
	
// Return logic
if (isset($_GET['type_id'])) {
	if (isset($_GET['group_id'])) {
		echo json_encode($items[$_GET['type_id']][$_GET['group_id']]);
	} else {
		echo json_encode($groups[$_GET['type_id']]);
	}
	return;
}

echo json_encode($types);
