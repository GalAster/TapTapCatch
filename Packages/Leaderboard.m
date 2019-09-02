(* ::Package:: *)

raw = Import["https://www.taptap.com/ajax/top/download?page=1&total=0", "RawJSON"]["data", "html"];


xml = ImportString[raw, {"HTML", "XMLObject"}];


Handler["div", {"class" -> "taptap-top-card"}, cell_] := TopCard[cell]
Handler["div", {"class" -> "top-card-left"}, cell_] := Block[
	{dict = Association@cell[[2, -1, 2, 2]]},
	LeftCard[
		"## " <> dict["title"],
		First@StringSplit[dict["src"], "?"]
	]
]
Handler["div", {"class" -> "top-card-right image-width"}, cell_] := Block[
	{dict = Association@cell[[2, -1, 2, -1, 2, 2]]},
	LeftCard[
		First@StringSplit[dict["src"], "?"]
	]
]
Handler["div", {"class" -> "card-tags"}, cell_] := Block[
	{},
	Tags[cell]
]
Handler["a", info_, {text_String}] := Block[
	{dict = Association@info},
	AppendTo[dict, "text" -> text];
	Return@dict
]

Handler["span", {"class" -> "top-card-order-triangle gold"}, ___] := Nothing;
Handler["span", {"class" -> "top-card-order-text orange"}, ___] := Nothing;
Handler["h4", ___] := Nothing;



Handler["p", {"class" -> "card-middle-author"}, {"\n                            ", Handler["a", {"shape" -> "rect", "href" -> "https://www.taptap.com/developer/1"}, {"\:5382\:5546:\[NonBreakingSpace]\:5fc3\:52a8\:7f51\:7edc"}], "\n                    "}]


(* ::Input:: *)
(**)
(**)
(**)


Flatten[xml[[2, -1, -1, -1]] /. XMLElement -> Handler]
