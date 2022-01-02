
# --- Read scores ---
# test,item,score,speaker_name,speaker,rater,rater_gender,rater_age,speaker_wav

all <- fread("all.csv",
             drop = c("rater_gender","rater_age","speaker"),
             colClasses=list(character=c("item","speaker_name","speaker_wav","rater")),
             stringsAsFactors = TRUE
)
all$speaker_name <- factor(all$speaker_name, c("S1_NARR", "S1_CHAR", "S1_NEU",
                                               "S2_NARR", "S2_CHAR", "S2_NEU",
                                               "S3_NARR", "S3_CHAR", "S3_NEU"
))

#   Normalize scores of each rater separately
scores <- all[, .(test,item,score=as.vector(scale(score)),speaker_name, speaker_wav), by = rater]

gender <- c("F"="female", "M"="male")

# --- Read eGeMAPS ---

# create Latex expression lookup table for eGemaps variables
d <- fread("lookup.csv")
tr.vec <- d$expr
names(tr.vec) <- d$var
tr <- function (var) {str2expression(tr.vec[var])}
tr.jax <- d$mathjax
names(tr.jax) <- d$var
tr2jax <- function (var) {tr.jax[var]}
# Load data
egemaps <- fread( "egemaps.csv", stringsAsFactors = TRUE, drop = "frameTime")

## Normalize acoustic parameters
egemaps.start <- 3
l <- length(names(egemaps))
egemaps.vars <- names(egemaps)[egemaps.start:l]
egemaps.scaled <- cbind(egemaps[, 1:(egemaps.start-1)], scale(egemaps[, egemaps.start:l]) )

#fixme unused
effect_size <- function(var, data) {
  r <- rank_epsilon_squared(formula(paste(var, " ~ style")), data = data)
  data.frame(
    name = var,
    rank_epsilon_squared = r$rank_epsilon_squared
  )
}

# Sort by effect size and convert to long
sort_by_effect <- function(data) {
  long <- melt(data, id.vars=c("style", "file"))
  long$variable <- factor(long$variable, levels = rev(levels(long$variable)))
  #return not sorted for now
  long
}

egemaps.long <- sort_by_effect(egemaps.scaled)

params <- c(
  "spectralFlux_sma3_amean",
  "MeanVoicedSegmentLengthSec",
  "MeanUnvoicedSegmentLength",
  "VoicedSegmentsPerSec",
  "loudnessPeaksPerSec",
  "loudness_sma3_amean",
  "loudness_sma3_meanRisingSlope",
  "loudness_sma3_meanFallingSlope",
  "HNRdBACF_sma3nz_amean",
  "alphaRatioV_sma3nz_amean",
  "alphaRatioUV_sma3nz_amean",
  "slopeV0.500_sma3nz_amean",
  "slopeUV0.500_sma3nz_amean"
)
