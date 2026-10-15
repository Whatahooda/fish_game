if (active && !fade)
{
	other.PlayerHit(damage, given_invulnerability, knockback);
	if (destroy_on_collision) ProjectileFinish();
}
