package;

class RatingsData
{
	public static var grafexAnalogRatings:Array<Dynamic> = [
		["F", 0.41], // 40%
		["D", 0.66], // 65%
		["C", 0.76], // 75%
		["B", 0.86], // 85%
		["A", 0.94], // 93%
		["S-", 0.96], // 95%
		["S", 0.98], // 97%
		["S+", 0.99], // 98%
		["SS", 1] // 100%
	];

	public static var loreRatings:Array<Dynamic> = [
		['You Suck!', 0.46], // 0 to 45
		['F', 0.51], // 45 to F50
		['D-', 0.56], // 50 to 55
		['D', 0.59], // 55 to 58
		['D+', 0.65], // 58 to 64
		['C-', 0.69], //64 to 68
		['C', 0.73], // 68 to 72
		['C+', 0.77], // 72 to 76
		['B-', 0.81], // 76 to 80
		['B', 0.84], // 80 to 83
		['B+', 0.87], // 83 to 86
		['A-', 0.9], // 86 to 89
		['A', 0.93], // 89 to 92
		['A+', 0.95], // 92 to 94
		['S', 0.97], // 94 to 96
		['S+', 0.99], // 96 to 98
		['S++', 1], // 98 to 99.99
		['Perfect', 1] // 100
	];

	public static var denpaRatings:Array<Dynamic> = [
		['How?', 0.2], //From 0% to 19%
		['F', 0.4], //From 20% to 39%
		['E', 0.5], //From 40% to 49%
		['D', 0.6], //From 50% to 59%
		['C', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['B', 0.8], //From 70% to 79%
		['A', 0.9], //From 80% to 89%
		['S', 1], //From 90% to 99%
		['X', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var foreverRatings:Array<Dynamic> = [
		["F", 0.2], // 65%
		["E", 0.3], // 70%
		["D", 0.4], // 75%
		["C", 0.7], // 80%
		["B", 0.8], // 85%
		["A", 0.9], // 90%
		["S", 1], // 99.9%
		["S+", 1] // 100%
	];

	public static var andromedaRatings:Array<Dynamic> = [
		["D", 0.46], // 45%
		["D+", 0.51], // 50%
		["C-", 0.56], // 55%
		["C", 0.61], // 60%
		["C+", 0.65], // 64%
		["B-", 0.69], // 68%
		["B", 0.73], // 72%
		["B+", 0.77], // 76%
		["A-", 0.81], // 80%
		["A", 0.84], // 83%
		["A+", 0.87], // 86%
		["S-", 0.9], // 89%
		["S", 0.93], // 92%
		["S+", 0.95], // 94%
		["☆", 0.97], // 96%
		["☆☆", 0.99], // 98%
		["☆☆☆", 1], // 99.99%
		["☆☆☆☆", 1] // 100%
	];

	public static var micdUpRatings:Array<Dynamic> = [
		['F', 0.3], //From 11% to 19%
		['E', 0.4], //From 20% to 39%
		['D', 0.5], //From 40% to 49%
		['C', 0.6], //From 50% to 59%
		['B', 0.69], //From 60% to 68%
		['A-', 0.8], //From 70% to 79%
		['A', 0.84], //From 80% to 83%
		['A+', 0.9], //From 84% to 89%
		['S-', 0.91], //From 90% to 91%
		['S', 0.92], //92%
		['S+', 0.93], //93%
		['SS-', 0.94], //94%
		['SS', 0.95], //95%
		['SS+', 0.96], //From 96% to 97%
		['X-', 0.99], //98%
		['X', 1], //99%
	];

	public static var unknownRatings:Array<Dynamic> = [
		['Uninstall', 0.2], //From 0% to 10%
		['F', 0.3], //From 11% to 19%
		['E', 0.4], //From 20% to 39%
		['D', 0.5], //From 40% to 49%
		['C', 0.6], //From 50% to 59%
		['B', 0.69], //From 60% to 68%
		['Nice', 0.7], //69% haha so funni
		['A-', 0.8], //From 70% to 79%
		['A', 0.84], //From 80% to 83%
		['A+', 0.9], //From 84% to 89%
		['S-', 0.91], //From 90% to 91%
		['S', 0.92], //92%
		['S+', 0.93], //93%
		['SS-', 0.94], //94%
		['SS', 0.95], //95%
		['SS+', 0.96], //From 96% to 97%
		['X-', 0.99], //98%
		['X', 1], //99%
		['PERFECT!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var psychRatings:Array<Dynamic> = [
		['You Suck!', 0.2], //From 0% to 19%
		['Shit', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Sick!', 1], //From 90% to 99%
		['Perfect!!', 1] //100%
	];

	public static var owoRatings:Array<Dynamic> = [
		['*Sad OwO Noises*', 0.4], //From 20% to 39%
        ['Bowing...', 0.5], //From 40% to 49%
        ['You get a bit bettew', 0.6], //From 50% to 59%
        ['Awooo', 0.69], //From 60% to 68%
        ['OwO', 0.7], //69%
        ['Not Bad Fuwwy Bou UwU', 0.8], //From 70% to 79%
        ['*nuzzles* That wash amazing!!', 0.9], //From 80% to 89%
        ['Pawsome!', 1], //From 90% to 99%
        ['Incwedibwe!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var joalor64Ratings:Array<Dynamic> = [
        ['Trashy player lol', 0.2], //From 0% to 19%
		['...No', 0.4], //From 20% to 39%
		['It is not overcharted, you are just bad', 0.5], //From 40% to 49%
		['what', 0.6], //From 50% to 59%
		['Okay IG', 0.69], //From 60% to 68%
		['N I C E', 0.7], //69%
		['git gud', 0.8], //From 70% to 79%
		['Material Gworl', 0.9], //From 80% to 89%
		['Cool!', 1], //From 90% to 99%
		['Epic!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var blueberryRatings:Array<Dynamic> = [
		['SHIT!!!!', 0],
		['SHIT!!!', 0.15],
        ['SHIT!!', 0.25],
		['SHIT!', 0.35],
		['BAD!!!', 0.40],
		['BAD!!', 0.45],
		['BAD!', 0.55],
		['GOOD!', 0.65],
		['GOOD!!', 0.70],
		['GOOD!!!', 0.85],
		['SICK!', 0.9],
		['SICK!!', 0.95],
		['SICK!!!', 1]
	];

	public static var projectOldRatings:Array<Dynamic> = [
        ['F', 0.2], //From 40% to 49%
        ['E', 0.3], //From 50% to 59%
        ['D', 0.6], //From 60% to 68%
        ['C', 0.7], //69%
        ['B', 0.8], //From 70% to 79%
        ['A', 0.9], //From 80% to 89%
        ['S', 0.9], //From 90% to 99%
        ['SFC', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var cubeRatings:Array<Dynamic> = [
        ['bitch do you even exist', 0.1], //your accuracy is actual garbage if you get to this point
		['F', 0.2], //From 0% to 19%
		['E', 0.4], //From 20% to 39%
		['D', 0.5], //From 40% to 49%
		['C', 0.6], //From 50% to 59%
		['B', 0.69], //From 60% to 68%
		['comedy', 0.7], //69%
		['A', 0.8], //From 70% to 79%
		['S', 0.9], //From 80% to 89%
		['S+', 1], //From 90% to 99%
		['S++', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var noBotplayLagRatings:Array<Dynamic> = [
		['you suck ass lol', 0.2], //From 0% to 19%
		['you aint doin good', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['funny number', 0.7], //69%
		['nice', 0.8], //From 70% to 79%
		['awesome', 0.9], //From 80% to 89%
		['thats amazing', 1], //From 90% to 99%
		['PERFECT!!!!!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var theoyeahRatings:Array<Dynamic> = [
		['Its not hard you just suck as hell', 0.2], //From 0% to 19%
		['skill issue', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Ok', 0.6], //From 50% to 59%
		['Not Bad', 0.69], //From 60% to 68%
		['Great', 0.7], //69%
		['Cool!', 0.8], //From 70% to 79%
		['Good!', 0.9], //From 80% to 89%
		['Sick!!', 1], //From 90% to 99%
		['Perfect!!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var osRatings:Array<Dynamic> = [
		['F', 0.2], //From 0% to 19%
		['E', 0.4], //From 20% to 39%
		['D', 0.5], //From 40% to 49%
		['C', 0.6], //From 50% to 59%
		['B', 0.69], //From 60% to 68%
		['A', 0.7], //69%
		['AA', 0.8], //From 70% to 79%
		['AAA', 0.9], //From 80% to 89%
		['AAAA', 1], //From 90% to 99%
		['AAAAA', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var niceRatings:Array<Dynamic> = [
		["PLAY A DIFFERENT SONG PLEASE", 0.1], //From 0% to 5%
		["how are you still alive", 0.05], //From 5% to 10%
		["what are you playing that has your accuracy this low", 0.1], //From 1% to 15%
		["death", 0.15], //From 15% to 20%
		["oh no", 0.2], //From 20% to 30%
		["guh?!!?!!?!", 0.3], //From 30% to 40%
		[":skull:", 0.4], //From 40% to 50%
		["you're bad", 0.5], //From 50% to 60%
		["losing", 0.6], //From 60% to 65%
		["mad cuz bad", 0.65], //From 65% to 69%
		["FUNNY NUMBER", 0.69], //From 69% to 70%
		["bad", 0.7], //From 70% to 75%
		["missing", 0.75], //From 75% to 80%
		["is that all you got", 0.8], //From 80% to 95%
		["whoops", 0.85], //From 85% to 90%
		["great", 0.9], //From 90% to 94%
		["lmao you failed the pfc", 0.94], //From 94% to 99%
		["how are you pfcing this it isnt even possible what the fuck", 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var ox9Ratings:Array<Dynamic> = [
		['Horrible', 0.4], //From 20% to 39%
        ['Meh.', 0.5], //From 40% to 49%
        ['Uhm', 0.6], //From 50% to 59%
        ['Eh', 0.69], //From 60% to 68%
        ['hehe boy', 0.7], //69%
        ['Nice', 0.8], //From 70% to 79%
        ['Good', 0.9], //From 80% to 89%
        ['Awesome!', 1], //From 90% to 99%
        ['HAX!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var stridentcrisisRatings:Array<Dynamic> = [
		['Cope Harder', 0.2], //From 0% to 19%
		['Done For.', 0.4], //From 20% to 39%
		['It\'s not overcharted, you\'re just bad.', 0.5], //From 40% to 49%
		['Ok', 0.6], //From 50% to 59%
		['Eh', 0.69], //From 60% to 68%
		['gamer moment', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Cheater!', 1], //From 90% to 99%
		['Haxxer!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public static var leRatings:Array<Dynamic> = [
		["how tf u this bad", 0], // 65%
		["OOF", 0.02], // 70%
		["Really Bad", 0.1], // 75%
		["Bad", 0.35], // 80%
		["Ok", 0.5], // 85%
		["Good", 0.6], // 90%
		["Sick", 0.85], // 99.9%
		["Perfect", 1] // 100%
	];

	public static var accurateRatings:Array<Dynamic> = [
		["D", 0.401], // 40%
		["C", 0.6], // 59%
		["C", 0.7], // 69%
		["B", 0.8], // 79%
		["A", 0.86], // 85%
		["A.", 0.9], // 89%
		["A:", 0.96], // 95%
		["AA", 0.976], // 97.5%
		["AA.", 0.981], // 98%
		["AA:", 0.986], // 98.5%
		["AAA", 0.991], // 99%
		["AAA.", 0.9936], // 99.35%
		["AAA:", 0.9959], // 99.58%
		["AAAA", 0.998], // 99.79%
		["AAAA.", 0.9989], // 99.88%
		["AAAA:", 0.9999], // 99.97%
		["AAAAA", 1] // 99.99%
	];

	public static var maniaRatings:Array<Dynamic> = [
        ['D', 0.61], //60%
        ['C', 0.71], //70%
        ['B', 0.81], //80%
        ['A', 0.91], //90%
        ['S', 0.96], //95%
        ['X', 1] // 100%
    ];

	public static var errorRating:Array<Dynamic> = [[null, 1]];
}