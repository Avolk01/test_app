class RegState {

  const RegState._({
    this.exceptionMessage = '',
    this.feedback = '',
  });

  const RegState.waiting() : this._();

  const RegState.exception(String message) : this._(exceptionMessage: message);
  const RegState.complete(String feedback) : this._(feedback: feedback);

  final String exceptionMessage;
  final String feedback;
}

