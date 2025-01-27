#include "../client.h"
#include "../corpse.h"

void command_summonburiedplayercorpse(Client *c, const Seperator *sep)
{
	auto target = c;
	if (c->GetTarget() && c->GetTarget()->IsClient() && c->GetGM()) {
		target = c->GetTarget()->CastToClient();
	}

	c->Message(Chat::Yellow, "Recovering one corpse...");
	auto *corpse = database.SummonBuriedCharacterCorpses(
		target->CharacterID(),
		target->GetZoneID(),
		zone->GetInstanceID(),
		target->GetPosition()
	);

	if (!corpse) {
		c->Message(
			Chat::White,
			fmt::format(
				"{} {} not have any expired corpses.",
				c->GetTargetDescription(target, TargetDescriptionType::UCYou),
				c == target ? "do" : "does"
			).c_str()
		);
	}
}

