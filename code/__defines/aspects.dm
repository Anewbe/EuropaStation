#define HAS_ASPECT(holder, check_aspect) (ismob(holder) && holder.mind && LAZYLEN(holder.mind.aspects) && holder.mind.aspects[check_aspect])

#define ADD_ASPECT(holder, add_aspect) \
	if(!HAS_ASPECT(holder, add_aspect)) { \
		var/decl/aspect/A = aspects_by_name[add_aspect]; \
		if(holder && holder.mind && istype(A)) { \
			if(!holder.mind.aspects) { \
				holder.mind.aspects = list(); \
			} \
			holder.mind.aspects[add_aspect] = TRUE; \
			A.do_post_spawn(holder); \
		} \
	}

// General aspects.
#define ASPECT_HOTSTUFF         "Hot Stuff"
#define ASPECT_HARDY            "Hardy"
#define ASPECT_THICKBONES       "Thick Bones"
#define ASPECT_SCARRED          "Scarred"
#define ASPECT_APPRAISER        "Appraiser"
#define ASPECT_SHARPEYED        "Sharp-Eyed"
#define ASPECT_RADHARDENED      "Lead Poisoning"
#define ASPECT_UNCANNY          "Uncanny"
#define ASPECT_FRAGILE          "Fragile"
#define ASPECT_GLASS_BONES      "Glass Bones"
#define ASPECT_PAPER_SKIN       "Paper Skin"
#define ASPECT_HAEMOPHILE       "Haemophile"
#define ASPECT_GROUNDBREAKER    "Groundbreaker"
#define ASPECT_HANDYMAN         "Handyman"
#define ASPECT_FIRSTAID         "First Responder"
#define ASPECT_SAWBONES         "Sawbones"
#define ASPECT_GUNSMITH         "Gunsmith"
#define ASPECT_MARKSMAN         "Marksman"
#define ASPECT_DUALWIELD        "Guns Akimbo"
#define ASPECT_BASICGUNS        "Person of Caliber"
#define ASPECT_HACKER           "Hackerman"
#define ASPECT_COMPANYMAN       "Company Man"
#define ASPECT_JUNKIE           "Junkie"
#define ASPECT_GREENTHUMB       "Green Thumb"
#define ASPECT_NINJA            "Knife Thrower"
#define ASPECT_TRIBAL           "Tribal"
#define ASPECT_MEATY            "Big Hands"
#define ASPECT_CLUMSY           "Clumsy"
#define ASPECT_EPILEPTIC        "Epileptic"
#define ASPECT_ASTHMATIC        "Asthmatic"
#define ASPECT_NEARSIGHTED      "Nearsighted"
#define ASPECT_NERVOUS          "Nervous"
#define ASPECT_DEAF             "Deaf"
#define ASPECT_BLIND            "Blind"

// Combat aspects
#define ASPECT_WRESTLER         "Wrestler"
#define ASPECT_BRAWLER          "Brawler"
#define ASPECT_GUNPLAY          "Gunslinger"
#define ASPECT_TASER            "Pacifier"

// Skill aspects.
#define ASPECT_DIAGNOSTICIAN    "Diagnostician"
#define ASPECT_BUILDER          "Construction Worker"
#define ASPECT_EXOSUIT_PILOT    "Exosuit Pilot"
#define ASPECT_EXOSUIT_TECH     "Exosuit Technician"
#define ASPECT_JOGGER           "Jogger"
#define ASPECT_DAREDEVIL        "Daredevil"
#define ASPECT_PHARMACIST       "Pharmacist"

// Psychic aspects.
#define ASPECT_PSI_ROOT         "Gifted"
#define ASPECT_PSI_COERCION_L   "Latent Coercive Faculty"
#define ASPECT_PSI_COERCION_O   "Operant Coercive Faculty"
#define ASPECT_PSI_COERCION_MC  "Master Coercor"
#define ASPECT_PSI_COERCION_GMC "Grandmaster Coercor"
#define ASPECT_PSI_CREATIVE_L   "Latent Energistic Faculty"
#define ASPECT_PSI_CREATIVE_O   "Operant Energistic Faculty"
#define ASPECT_PSI_CREATIVE_MC  "Master Energizer"
#define ASPECT_PSI_CREATIVE_GMC "Grandmaster Creator"
#define ASPECT_PSI_PKINESIS_L   "Latent Psychokinetic Faculty"
#define ASPECT_PSI_PKINESIS_O   "Operant Psychokinetic Faculty"
#define ASPECT_PSI_PKINESIS_MC  "Master Psychokinetic"
#define ASPECT_PSI_PKINESIS_GMC "Grandmaster Psychokinetic"
#define ASPECT_PSI_REDACTOR_L   "Latent Biokinetic Faculty"
#define ASPECT_PSI_REDACTOR_O   "Operant Biokinetic Faculty"
#define ASPECT_PSI_REDACTOR_MC  "Master Biokinetic"
#define ASPECT_PSI_REDACTOR_GMC "Grandmaster Biokinetic"

// Restricted aspects.
#define ASPECT_XRAY             "X-Ray Vision"