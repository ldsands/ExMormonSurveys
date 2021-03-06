function [outCategorical, outQuestions] = ArrangeCategoricalAnalysis(inData)
%%%%%%%%%%%  Enter Categorical Data Options  %%%%%%%%%%%%%%

%inColumn,inResponses, inMultiple
Participated = {'Yes','No','Don''t remember'};
ParticipatedExp = ExpandMultipleChoice(inData(:,2),Participated,false);

Gender = {'Male','Female','Transgender or a non-conforming gender'};
GenderExp = ExpandMultipleChoice(inData(:,4),Gender,false);

Orientation = {'Heterosexual ("Straight")','Bisexual', 'Homosexual ("Gay or Lesbian")', 'Asexual, unsure, or other orientation'};
OrientationExp = ExpandMultipleChoice(inData(:,5),Orientation,false);

CurrentMaritalStatus = {'Single (never married)', 'Currently married', 'Polygamously Married', 'Separated', 'Divorced', 'Widowed'};
CurrentMaritalStatusExp = ExpandMultipleChoice(inData(:,6),CurrentMaritalStatus,false);

PriorMaritalStatus = {'Single (never married)', 'Married', 'Polygamously Married', 'Separated', 'Divorced', 'Widowed'};
PriorMaritalStatusExp = ExpandMultipleChoice(inData(:,7),PriorMaritalStatus,false);

MembershipStatus = {'Inactive member', 'Post-Mormon (no longer identify as Mormon in any way)', ...
    'Active member (no specific or concrete plans of leaving)', 'Resigned', ...
    'Transitional member (NOM, Exploring, current attending for various reasons but working my way out)', ...
    'Other (Please write it in)', 'Excommunicated (question added after first ~120 respondents)', ...
    'Currently under church discipline'};
MembershipStatusExp = ExpandMultipleChoice(inData(:,17),MembershipStatus,false);  

HowJoined = {'Born into a Mormon family where both parents were active', 'Born into a mixed-faith home', ...
    'Convert (I joined the church because I wanted to, any age)', 'Family joined the church before I was 12', ...
    'Other (please write it in)', 'Family joined the church when I was between 13 and 18'};
HowJoinedExp = ExpandMultipleChoice(inData(:,19),HowJoined,false);  

Callings = {'Never held a calling', 'Calling as a youth (YM/YW age)', ...
    'Committee calling or a calling not found in the official handbook', 'Teaching/Sunday School', ...
    'Primary/Nursery/Ward Choir/Pianist/Ward Missionary/Family History/Other Auxiliary', ...
    'YM/YW/Sunday School Presidency/Ward Mission Leader', 'Elders Quorum/Relief Society Presidency', ...
    'Bishopric/Branch presidency secretaries/clerks', 'Bishopric / Branch presidency', 'High Priest Leadership', ...
    'Stake Calling', 'Stake Presidency', 'Evangelist', 'Mission, Area, Temple or counselor', 'General Authority', ...
    'Patriarch', 'Other (Please write it in)'};
CallingsExp = ExpandMultipleChoice(inData(:,21),Callings,true); 
%Flatten the callings columns to only represent the max calling ever held
MaxCalling = flattenCallings(CallingsExp); %calculate the highest calling ever held (larger is better)
  
Mission = {'Yes','No'};
MissionExp = ExpandMultipleChoice(inData(:,23),Mission,false); 

Temple = {'Never participated', 'Sealings (as a child, parents to children)', 'Baptisms for the dead', 'Initiatory', ...
     'Endowments', 'Sealings (between spouses)', 'Temple worker', 'Second Anointing', 'Washing of the feet', ...
     'Public services in Kirtland or Independence (Community of Christ)', ...
     'Private services in Kirtland or Independence (community of Christ)', 'Other (Please write it in)'};
TempleExp = ExpandMultipleChoice(inData(:,24),Temple,true); 
 
Sealed = {'Yes - married and sealed on the same day', 'Yes - sealed a later day, after our wedding day', 'No'};
SealedExp = ExpandMultipleChoice(inData(:,26),Sealed,false); 

TypicalActivity = {'Never attended', 'Attended long enough to get each child baptized', ...
    'Attended big holidays or family events', 'Attended off and on, but at least several times each year', ...
    'Attended roughly every other Sunday', ...
    'Attended most Sundays but did not usually stay for more than sacrament or go to weekday meetings', ...
    'Attended most Sundays and most weekday meetings', ...
    'Attended nearly every meeting, fireside, and paid conference I could (and maybe felt bad if I didn''t)', ...
    'Other (please write it in)'};
TypicalActivityExp = ExpandMultipleChoice(inData(:,27),TypicalActivity,false); 

PrimeActivity = {'Never attended', 'Attended long enough to get each child baptized', ...
    'Attended big holidays or family events', 'Attended off and on, but at least several times each year', ...
    'Attended roughly every other Sunday', ...
    'Attended most Sundays but did not usually stay for more than sacrament or go to weekday meetings', ...
    'Attended most Sundays and most weekday meetings', ...
    'Attended nearly every meeting, fireside, and paid conference I could (and maybe felt bad if I didn''t)', ...
    'Other (please write it in)'};
PrimeActivityExp = ExpandMultipleChoice(inData(:,29),PrimeActivity,false); 

CurrentActivity = {'Not attending','Attending long enough to get each child baptized', ...
    'Attending big holidays or family events', 'Attending off and on, but at least several times each year', ...
    'Attending roughly every other Sunday', ...
    'Attending most Sundays but do not usually stay for more than sacrament or go to weekday meetings', ...
    'Attending most Sundays and most weekday meetings', 'Attending nearly every meeting, fireside, and paid conference I can', ...
    'Other (please write it in)'};
CurrentActivityExp = ExpandMultipleChoice(inData(:,31),CurrentActivity,false); 

SexualMisconduct = {'Yes, often', 'Yes, occasionally', 'Yes, but only on a few instances', 'No', 'Other (please write it in)'};
SexualMisconductExp = ExpandMultipleChoice(inData(33),SexualMisconduct,false);

WhoAbused = {'I did not experience sexual misconduct', 'A youth or someone without an ecclesiastical role', 'A YM/YW leader', ...
    'A home teacher', 'A member of the bishopric', 'A member of the stake presidency', 'Other (please write in, if comfortable)'};
WhoAbusedExp = ExpandMultipleChoice(inData(35),WhoAbused,true);

HowAbused = {'Worthiness interviews that were inappropriate', 'Other, I''d rather not disclose', 'Other (please write it in)'};
HowAbusedExp = ExpandMultipleChoice(inData(37),HowAbused,true);

StrongestBeliefs = {'I never questioned any of these doctrines', ...
    'The Church of Jesus Christ LDS being the one true church and having the sole claim to the priesthood', ...
    'I never believed any of these doctrines', ...
    'The "curse of Cain" being a reason that blacks could not receive the priesthood until after 1978', ...
    'Jesus Christ being real and divine', 'The temple ceremonies being inspired by God', ...
    'The atonement and the ability to change and repent', 'Eternal marriage (polygamous)', ...
    'The Godhead (three unique, embodied beings who are Gods)', 'Eternal marriage (monogamous)', 'Heavenly mother(s)', ...
    'The work for the dead/family history being necessary for salvation', ...
    'Holy Ghost/Light of Christ providing comfort and guidance', 'The plan of salvation', 'Miracles', 'Becoming a god', ...
    'God hears and answers prayers', 'The word of wisdom', ...
    'Joseph Smith being a true prophet who restored the original church in these latter days', 'The law of chastity', ...
    'The Book of Mormon being a true, historical book', 'The law of tithing / consecration', ...
    'D&C, Book of Abraham, and other translations and revelations being true and historical', ...
    'The Second Coming and Millennium are near', 'The current prophet being a true prophet', ...
    'Other (Please write it in)'};
StrongestBeliefsExp = ExpandMultipleChoice(inData(39),StrongestBeliefs,true);

WeakestBeliefs = {'I never questioned any of these doctrines', ...
    'The Church of Jesus Christ LDS being the one true church and having the sole claim to the priesthood', ...
    'I never believed any of these doctrines', ...
    'The "curse of Cain" being a reason that blacks could not receive the priesthood until after 1978', ...
    'Jesus Christ being real and divine', 'The temple ceremonies being inspired by God', ...
    'The atonement and the ability to change and repent', 'Eternal marriage (polygamous)', ...
    'The Godhead (three unique, embodied beings who are Gods)', 'Eternal marriage (monogamous)', 'Heavenly mother(s)', ...
    'The work for the dead/family history being necessary for salvation', ...
    'Holy Ghost/Light of Christ providing comfort and guidance', 'The plan of salvation', 'Miracles', 'Becoming a god', ...
    'God hears and answers prayers', 'The word of wisdom', ...
    'Joseph Smith being a true prophet who restored the original church in these latter days', 'The law of chastity', ...
    'The Book of Mormon being a true, historical book', 'The law of tithing / consecration', ...
    'D&C, Book of Abraham, and other translations and revelations being true and historical', ...
    'The Second Coming and Millennium are near', 'The current prophet being a true prophet', ...
    'Other (Please write it in)'};
WeakestBeliefsExp = ExpandMultipleChoice(inData(41),WeakestBeliefs,true);

BelovedPractices = {'Home/visiting teaching', 'Attending a live convert baptism', 'Keeping the Sabbath day holy', ...
    'Baptisms for the dead', 'Paying tithing and fast offerings', 'Initiatory/Endowment ceremony', 'Fasting for a purpose', ...
    'Sealing Ceremony', 'Rendering service', 'Keeping a food storage', 'Reading your scriptures', 'Doing family history', ...
    'Private prayer', 'Family home evening', 'Group prayer', 'Receiving a patriarchal blessing', 'Your own baptism', ...
    'Witnessing or participating in priesthood blessings, such as baby blessing, healings, Father''s blessings, etc.', ...
    'Taking the sacrament/communion', 'Avoiding sexual encounters', 'Attending meetings', ...
    'Avoiding coffee, tea, tobacco, alcohol, or drug abuse', 'Attending institute or other religion classes', ...
    'Other (Please write it in)'};
BelovedPracticesExp = ExpandMultipleChoice(inData(43),BelovedPractices,true);

HatedPractices = {'Home/visiting teaching', 'Attending a live convert baptism', 'Keeping the Sabbath day holy', ...
    'Baptisms for the dead', 'Paying tithing and fast offerings', 'Initiatory/Endowment ceremony', 'Fasting for a purpose', ...
    'Sealing Ceremony', 'Rendering service', 'Keeping a food storage', 'Reading your scriptures', 'Doing family history', ...
    'Private prayer', 'Family home evening', 'Group prayer', 'Receiving a patriarchal blessing', 'Your own baptism', ...
    'Witnessing or participating in priesthood blessings, such as baby blessing, healings, Father''s blessings, etc.', ...
    'Taking the sacrament/communion', 'Avoiding sexual encounters', 'Attending meetings', ...
    'Avoiding coffee, tea, tobacco, alcohol, or drug abuse', 'Attending institute or other religion classes', ...
    'Other (Please write it in)'};
HatedPracticesExp = ExpandMultipleChoice(inData(45),HatedPractices,true);

PrimaryReasonForApostasy = {'I never had a strong testimony', ...
    'Social justice problems with the church, including gay rights, sexism, racism, financial transparency, other church policies', ...
    'The troubling aspects of church history, including specific truth claims', ...
    'Doctrinal issues, including specific doctrines and contradictions within scriptures', ...
    'The historicity of scripture, including the Bible, Book of Mormon, etc.', 'Doctrines shifting over time', ...
    'Tired of the workload, not spiritually or socially satisfied for all the effort', ...
    'Lack of prophesy/leadership from the modern prophets', ...
    'Epistemological/philosophical problems, including spiritual witnesses found in other faiths and unreliability of spiritual knowledge', ...
    'Inability to control sinful nature, as defined by the church, including homosexuality, pornography, general chastity, keeping the Sabbath day holy, greed, etc.', ...
    'Personally offended by a member of the church that you know', ...
    'Had a spiritual experience that convinced you that the Mormon religion is not true', 'Other (please write in)'};
PrimaryReasonForApostasyExp = ExpandMultipleChoice(inData(48),PrimaryReasonForApostasy,false);

SocialReasons = {'None of these issues bothered me', 'The church''s efforts against gay marriage', ...
    'The treatment of gays, including at BYU, especially in the 1970''s', ...
    'The church teaching that homosexuality is a choice and inherently sinful', ...
    'The role of women in the church, including leadership positions and priesthood ordination', ...
    'The treatment of victims, including domestic violence, rape, sexual abuse, and child victims', ...
    'Private interviews covering sexual matters between adult men and children', ...
    'The racism, including denying blacks the priesthood, calling Amerindians "Lamanites" and Polynesians "Haggoth''s descendants", etc.', ...
    'Financial issues, including the lack of financial transparency, salaries for church leaders, and the low amounts given to humanitarian efforts', ...
    'The November policy', 'Family members without temple recommends being excluded from temple weddings', ...
    'Unsupervised interviews probing sexual behavior between a middle-aged man and children', 'Other (please write it in)'};
SocialReasonsExp = ExpandMultipleChoice(inData(51),SocialReasons,true);

HistoricalReasons = {'None of these issues bothered me', ...
    'Polygamy/polyandry/sexual predation, including the lies to hide it and the Nauvoo Expositor', ...
    'Brigham Young''s racism, including advocacy for slavery', 'Brigham Young''s sexism', ...
    'Blacks not receiving the priesthood', 'The Book of Abraham translation', ...
    'The lack of archaeological, linguistic, cultural, and other evidence for the Book of Mormon', ...
    'The evidence that shows the Book of Mormon is a 19th century work', 'The Kinderhook plates, Greek Psalter, etc.', ...
    'The evolution of Joseph''s claims, including the first vision, the priesthood restoration, his heavenly gift, etc.', ...
    'Joseph''s use of seer stones and other occult objects', 'The revisions to the Doctrine and Covenants', ...
    'The treatment of apostates, including Thomas Marsh, the Avenging Angels, the Danites', ...
    'The Salt Sermon / Danites / Avenging Angels', 'Masonic origins of the temple ceremony', 'Other (please write it in)'};
HistoricalReasonsExp = ExpandMultipleChoice(inData(53),HistoricalReasons,true);

DoctrinalContradictions = {'None of these issues bothered me', 'The incompatibility of Mormon scriptures with Biblical Christianity', ...
    'Differences between the current marriage and salvation doctrines and D&C 132', ...
    'Differences between modern interpretations of the Word of Wisdom and the scriptural version', ...
    'Difference between the current church hierarchy / power distribution and the organization found in the D&C', ...
    'Other (please write it in)'};
DoctrinalContradictionsExp = ExpandMultipleChoice(inData(55),DoctrinalContradictions,true);

ScriptureHistoricity = {'The historicity of these scriptures did not bother me', 'Old Testament', 'New Testament', ...
    'Book of Mormon', 'Book of Abraham', 'Book of Moses', 'Joseph Smith Translation', 'Joseph Smith - History', ...
    'Doctrine and Covenants', 'Other (please write it in)'};
ScriptureHistoricityExp = ExpandMultipleChoice(inData(57),ScriptureHistoricity,true);

UncomfortableDoctrines = {'None of these doctrines bothered me', 'The Adam-God doctrine', 'Blood atonement', ...
    'Blacks not receiving the priesthood due to the curse of Cain until 1978', 'The plan of salvation', ...
    'The nature of God (Trinitarianism to henotheism)', 'The changes to the temple ceremonies', ...
    'Polygamy being required for exaltation', 'The shift from revelations to declarations to proclamations to news-room announcements', ...
    'Young earth creationism', 'Abortion, birth control, and other sexual issues', 'Tithing', 'Other (please write it in)'};
UncomfortableDoctrinesExp = ExpandMultipleChoice(inData(59),UncomfortableDoctrines,true);

SinfulReasons = {'None (please check "other" if doing analysis, since this answer was added late)', 'Pornography/masturbation', ...
    'Same-sex attraction/homosexuality', 'Keeping the Sabbath day holy', 'Fornication/adultery (heterosexual)', ...
    'Keeping the Word of Wisdom', 'Other (please write it in)'};
SinfulReasonsExp = ExpandMultipleChoice(inData(61),SinfulReasons,true);

UncomfortableChurchExperiences = {'The temple endowment', 'Sexual misconduct', 'Sacrament/worship not fulfilling', ...
    'Shunning, gas-lighting, treatment of apostates', 'Home teaching', 'Lack of miracles, lack of healing', ...
    'Learning you had been lied to about history', 'Other (please write it in)'};
UncomfortableChurchExperiencesExp = ExpandMultipleChoice(inData(63),UncomfortableChurchExperiences,true);

MissAboutChurch = {'Sense of identity and associating with a "force for good"', 'The built-in social network', 'Reputation', ...
    'Service opportunities', 'Other (please write it in)'};
MissAboutChurchExp = ExpandMultipleChoice(inData(66),MissAboutChurch,true);

TransitionResources = {'LDS.org and official, published literature (currently in print)', ...
    'Books and other media authored by general authorities, including "unofficial" books', ...
    'Primary sources, including journals, transcripts, the Journal of Discourses etc.', ...
    'Unofficial faithful sources, including the Bloggernacle', ...
    'Critical compilation sources, including the CES Letter, Letter to my Wife, Letter to an Apostle, and Mormonthink', ...
    'Critical books, including Grant Palmer, Fawn Brodie, etc.', 'Apologetic sources, including fairmormon.org', ...
    'Secular sources, including Wikipedia', 'Atheist sources', ...
    '"Anti-Mormon" sources, including Outer Blogness, Mormons in Transition, the Tanners', ...
    'Story focused blogs and sites, including Mormon Stories, Year of Polygamy', ...
    'Exmormon-focused social media, including Facebook, Reddit, Recovery from Mormonism', ...
    'Believing-focused social media, including Facebook or Reddit', ...
    'Christian resources, including theological commentaries, sermons, books, etc.', 'Other (please write in)'};
TransitionResourcesExp = ExpandMultipleChoice(inData(68),TransitionResources,true);

CurrentResources = {'LDS.org and official, published literature (currently in print)', ...
    'Books and other media authored by general authorities, including "unofficial" books', ...
    'Primary sources, including journals, transcripts, the Journal of Discourses etc.', ...
    'Unofficial faithful sources, including the Bloggernacle', ...
    'Critical compilation sources, including the CES Letter, Letter to my Wife, Letter to an Apostle, and Mormonthink', ...
    'Critical books, including Grant Palmer, Fawn Brodie, etc.', 'Apologetic sources, including fairmormon.org', ...
    'Secular sources, including Wikipedia', 'Atheist sources', ...
    '"Anti-Mormon" sources, including Outer Blogness, Mormons in Transition, the Tanners', ...
    'Story focused blogs and sites, including Mormon Stories, Year of Polygamy', ...
    'Exmormon-focused social media, including Facebook, Reddit, Recovery from Mormonism', ...
    'Believing-focused social media, including Facebook or Reddit', ...
    'Christian resources, including theological commentaries, sermons, books, etc.', 'Other (please write in)'};
CurrentResourcesExp = ExpandMultipleChoice(inData(70),CurrentResources,true);

CurrentBelief = {'Agnostic - Non-Atheist, Non-Theist (if you don''t know, choose this one)', 'Atheist - Agnostic', ...
    'Atheist - Gnostic', 'Judeo-Christian Theist', 'Deist', 'Animist', 'Other Theist', 'Pantheist', 'Spiritualist', ...
    'Other (please write in)'};
CurrentBeliefExp = ExpandMultipleChoice(inData(74),CurrentBelief,false);

HarmfulTeachings = {'I do not find any of the teachings to be harmful', 'Teachings on family lines being broken by apostates', ...
    'Teachings on homosexuality', 'Teachings on sexual activity outside marriage', 'Teachings on pornography / masturbation', ...
    'Teachings on chastity, self worth, and modesty (i.e. rape culture, "chewed up gum" analogies, etc.)', ...
    'Teachings on sexual differences between genders', 'Teachings on womanhood and gender roles', 'Teachings regarding Jesus Christ', ...
    'Teachings regarding tithing', 'Teachings on the word of wisdom', ...
    'Teachings regarding emotions, including anger (contention), happiness, etc.', 'Teachings regarding blind obedience', ...
    'Teachings that make believers fear leaving the church', 'Other (Please write it in)'};
HarmfulTeachingsExp = ExpandMultipleChoice(inData(76),HarmfulTeachings,true);

FamilyReaction = {'They do not know yet', 'With joy and welcomed me back with open arms', ...
    'With indifference, they let me live my own life', 'With skepticism, they question my motives, but leave it at that', ...
    'With disdain, they strongly disagree with me, but we keep it civil or don''t talk about it.', ...
    'With utter contempt. I''ve been shunned and shut out of most family events.', 'I was legally disowned', 'Other (Please write it in)'};
FamilyReactionExp = ExpandMultipleChoice(inData(78),FamilyReaction,false);

LifestyleChanges = {'I have not made any changes to my lifestyle', 'Divorce', 'Stopped wearing my garments', ...
    'Using more pornography / masturbating more', 'Stopped paying my tithing', 'Drinking alcohol', ...
    'Living openly as homosexual', 'Using illegal drugs', 'Having sex with someone you are not married to', ...
    'Other (please write it in)'};
LifestyleChangesExp = ExpandMultipleChoice(inData(80),LifestyleChanges,true);


% This is the massive list of all the categorical choices in the survey
outCategorical = [Participated, Gender, Orientation, ...
    PriorMaritalStatus, CurrentMaritalStatus, ...
    MembershipStatus, HowJoined, 'MaxCalling', Mission, Temple, Sealed, ...
    TypicalActivity, PrimeActivity, CurrentActivity, SexualMisconduct, ...
    WhoAbused, HowAbused, StrongestBeliefs, WeakestBeliefs, ...
    BelovedPractices, HatedPractices, PrimaryReasonForApostasy, ...
    SocialReasons, HistoricalReasons, DoctrinalContradictions, ...
    ScriptureHistoricity, UncomfortableDoctrines, SinfulReasons, ...
    UncomfortableChurchExperiences, MissAboutChurch, TransitionResources, ...
    CurrentResources, CurrentBelief, HarmfulTeachings, FamilyReaction, ...
    LifestyleChanges; 
    ParticipatedExp, GenderExp, OrientationExp, ...
    PriorMaritalStatusExp, CurrentMaritalStatusExp, ...
    MembershipStatusExp, HowJoinedExp, MaxCalling, MissionExp, TempleExp, SealedExp, ...
    TypicalActivityExp, PrimeActivityExp, CurrentActivityExp, SexualMisconductExp, ...
    WhoAbusedExp, HowAbusedExp, StrongestBeliefsExp, WeakestBeliefsExp, ...
    BelovedPracticesExp, HatedPracticesExp, PrimaryReasonForApostasyExp, ...
    SocialReasonsExp, HistoricalReasonsExp, DoctrinalContradictionsExp, ...
    ScriptureHistoricityExp, UncomfortableDoctrinesExp, SinfulReasonsExp, ...
    UncomfortableChurchExperiencesExp, MissAboutChurchExp, TransitionResourcesExp, ...
    CurrentResourcesExp, CurrentBeliefExp, HarmfulTeachingsExp, FamilyReactionExp, ...
    LifestyleChangesExp ];

outQuestions = {'Participated', 'Gender', 'Orientation', ...
    'PriorMaritalStatus', 'CurrentMaritalStatus', 'Sect', 'SpouseLeave', ...
    'MembershipStatus', 'HowJoined', 'Callings', 'Mission', 'Temple', 'Sealed', ...
    'TypicalActivity', 'PrimeActivity', 'CurrentActivity', 'SexualMisconduct', ...
    'WhoAbused', 'HowAbused', 'StrongestBeliefs', 'WeakestBeliefs', ...
    'BelovedPractices', 'HatedPractices', 'PrimaryReasonForApostasy', ...
    'SocialReasons', 'HistoricalReasons', 'DoctrinalContradictions', ...
    'ScriptureHistoricity', ' UncomfortableDoctrines', 'SinfulReasons', ...
    'UncomfortableChurchExperiences', ' MissAboutChurch', 'TransitionResources', ...
    'CurrentResources', 'CurrentBelief', 'HarmfulTeachings', 'FamilyReaction', ...
    'LifestyleChanges'};
end

