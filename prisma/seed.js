import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  for (let i = 0; i < 15; i++) {
    await prisma.patient.create({
      data: {
        therapist: {
          connect: {
            id: 'e20b9f29-8dbe-4507-bacf-bb629a69f40a',
          },
        },
        user: {
          create: {
            email: `email-${i}@test.it`,
            address: 'Via Ignota, 3',
            name: 'Mario Rossi',
            roles: ['patient'],
            phone: '123123123',
            username: `username-${i}`,
          },
        },
        medicalRecord: {
          create: {
            anamnesticData: {
              create: {
                age: 26,
                sex: 'M',
                schooling: 'LM',
                birthPlace: 'Milano',
                previousInterventions: 'Nessun intervento pregresso',
                reason: 'Lorem ipsum dolor sit',
                pronoun: 'Lui'
              },
            },
            clinicalData: {
              create: {
                diagnosticHypothesis: 'Depressione',
                simptoms: 'Lorem ipsum dolor sit',
              },
            },
            intervention: {
              create: {
                frequency: 'Una volta a settimana',
                goals: 'Lorem ipsum dolor sit',
                therapeuticPlan:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Condimentum lacinia quis vel eros donec. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Adipiscing tristique risus nec feugiat. Lobortis feugiat vivamus at augue eget arcu dictum. Turpis cursus in hac habitasse platea dictumst quisque. Sollicitudin tempor id eu nisl. Nulla pharetra diam sit amet nisl. Proin sagittis nisl rhoncus mattis. Eget nulla facilisi etiam dignissim diam quis enim lobortis. Odio facilisis mauris sit amet massa vitae tortor condimentum.\n\nMollis aliquam ut porttitor leo a diam sollicitudin. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt. Tincidunt arcu non sodales neque sodales ut. Egestas maecenas pharetra convallis posuere morbi. Fermentum odio eu feugiat pretium nibh. Odio ut enim blandit volutpat maecenas volutpat blandit aliquam etiam. Neque viverra justo nec ultrices dui sapien eget mi. Nunc mi ipsum faucibus vitae. Lorem donec massa sapien faucibus et. Nunc mattis enim ut tellus elementum sagittis vitae et leo. Nulla facilisi etiam dignissim diam. Pretium quam vulputate dignissim suspendisse in. Diam vulputate ut pharetra sit amet aliquam id. Aliquet eget sit amet tellus cras adipiscing enim. Nisi vitae suscipit tellus mauris a diam maecenas. Amet cursus sit amet dictum sit amet justo donec. Odio euismod lacinia at quis risus sed vulputate.',
                takingChargeDate: '2023-10-09T15:57:29.406Z',
              },
            },
            ongoing: true,
          },
        },
      },
    });
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
