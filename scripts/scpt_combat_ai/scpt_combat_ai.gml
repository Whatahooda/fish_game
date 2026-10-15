/// Combat
// AI is comprised of different moves during combat.
// So we can have a basic combat with 2 or 3 different moves chosen at random.
// Or a complex fight of 10+ moves in a certain order + randomness

// List of ordered moves
// Random moves, and how many times we pick a random before switching to ordered again
// Customized delay between each move, can be 0

/*
Pick Order or Random first

Ordered -> Random -> Loops
OR
Random -> Ordered -> Loops
*/


// Basic Idea for combat order
/*
Combat begins
Start with our ordered or random moves, this is configurable
Get our move -> BeginMove(move_name, player_instance, combat_box_instance, _move_modifications?)
Move initiates -> somehow sends signal when the move is completed
Proceed to picking the next move
Loop
*/


/**
 * CombatAIData AI object that contains instructions for a combat happens(words not wording idk)
 * @param {String} _ai_id
 * @param {Array<String>} _moves_ordered Moves to use in the order provided
 * @param {Array<String>} _moves_random Moves to randomly pick from
 * @param {Array<String>} _moves_initial Moves to use at the start of this AI/combat
 * @param {Bool} _start_random Set to True for combat to start by picking from _moves_random
 * @param {Real} _delay_general The delay in seconds between each move, set to -1 to instead us specific delays
 * @param {Array<Real>} _delay_ordered Delay after each ordered move, must be the same length as _moves_ordered
 * @param {Array<Real>} _delay_random Delay after each random move, must be the same length as _moves_random
 */
function CombatAIData(_ai_id, _moves_ordered, _moves_random, _moves_initial, _start_random, _delay_general, _delay_ordered, _delay_random) constructor
{
	//if (ds_map_exists(obj_combat_storage_ai.combat_ai, _ai_id)) ai_id = _ai_id;
	//else show_error("FATAL	Combat AI ID \"" + _ai_id + "\" is undefined", true);
	ai_id = _ai_id;
	
	moves_ordered = _moves_ordered;
	moves_random = _moves_random;
	moves_initial = _moves_initial;
	start_random = _start_random;
	
	delay_general = _delay_general;
	delay_ordered = _delay_ordered;
	delay_random = _delay_random;
	
	moves_speed = 1.0;
	moves_size = 1.0;
}
